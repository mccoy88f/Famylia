import 'dart:io';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../util/ai_config_util.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => false; // uses own auth

  String get _adminEmail =>
      Platform.environment['ADMIN_EMAIL'] ?? 'admin@famylia.app';
  String get _adminPassword => Platform.environment['ADMIN_PASSWORD'] ?? '';

  Future<String> adminLogin(
      Session session, String email, String password) async {
    if (email != _adminEmail ||
        password != _adminPassword ||
        _adminPassword.isEmpty) {
      throw Exception('Invalid credentials');
    }
    return 'admin-ok';
  }

  Future<AiConfig> getAiConfig(Session session, String adminToken) async {
    _checkToken(adminToken);
    return AiConfigUtil.getConfig(session);
  }

  Future<AiConfig> setAiConfig(
    Session session,
    String adminToken,
    String provider,
    String modelName, {
    String? systemPrompt,
  }) async {
    _checkToken(adminToken);
    final config = await AiConfigUtil.getConfig(session);
    final providerEnum = AiProvider.values.firstWhere(
      (e) => e.name == provider,
      orElse: () => AiProvider.openrouter,
    );
    final updated = await AiConfig.db.updateRow(
      session,
      config.copyWith(
        provider: providerEnum,
        modelName: modelName,
        systemPrompt: systemPrompt,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    AiConfigUtil.invalidateCache();
    return updated;
  }

  Future<FamilyQuota?> getFamilyQuota(
      Session session, String adminToken, int familyId) async {
    _checkToken(adminToken);
    return FamilyQuota.db
        .findFirstRow(session, where: (t) => t.familyId.equals(familyId));
  }

  Future<FamilyQuota> setFamilyQuota(
    Session session,
    String adminToken,
    int familyId, {
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
  }) async {
    _checkToken(adminToken);
    final existing = await FamilyQuota.db
        .findFirstRow(session, where: (t) => t.familyId.equals(familyId));
    final now = DateTime.now().toUtc();
    if (existing == null) {
      return FamilyQuota.db.insertRow(
          session,
          FamilyQuota(
            familyId: familyId,
            monthlyTokenLimit: monthlyTokenLimit,
            monthlyCostLimitUsd: monthlyCostLimitUsd,
            updatedAt: now,
          ));
    }
    return FamilyQuota.db.updateRow(
        session,
        existing.copyWith(
          monthlyTokenLimit: monthlyTokenLimit,
          monthlyCostLimitUsd: monthlyCostLimitUsd,
          updatedAt: now,
        ));
  }

  Future<List<UsageStat>> getUsageStats(
    Session session,
    String adminToken, {
    int days = 30,
  }) async {
    _checkToken(adminToken);
    final since = DateTime.now().toUtc().subtract(Duration(days: days));
    final logs = await TokenUsageLog.db.find(
      session,
      where: (t) => t.createdAt.isAfter(since),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 5000,
    );

    // Group by familyId
    final Map<int, UsageStat> grouped = {};
    for (final log in logs) {
      final existing = grouped[log.familyId];
      if (existing == null) {
        grouped[log.familyId] = UsageStat(
          familyId: log.familyId,
          inputTokens: log.inputTokens,
          outputTokens: log.outputTokens,
          costUsd: log.costUsd,
          calls: 1,
        );
      } else {
        grouped[log.familyId] = existing.copyWith(
          inputTokens: existing.inputTokens + log.inputTokens,
          outputTokens: existing.outputTokens + log.outputTokens,
          costUsd: existing.costUsd + log.costUsd,
          calls: existing.calls + 1,
        );
      }
    }
    final result = grouped.values.toList();
    result.sort((a, b) => b.costUsd.compareTo(a.costUsd));
    return result;
  }

  void _checkToken(String token) {
    if (token != 'admin-ok') throw Exception('Unauthorized');
  }
}
