import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/family_repository.dart';
import '../theme/famylia_accent_presets.dart';

/// Famiglia attualmente selezionata (multi-famiglia) + accento tema + MarIA.
class FamilyContext extends ChangeNotifier {
  FamilyContext(this._prefs);

  final SharedPreferences _prefs;
  final _families = FamilyRepository();

  static const _keyActiveFamilyId = 'active_family_id';
  static const _keyActiveFamilyName = 'active_family_name';
  static const _keyAccentColor = 'active_family_accent';
  static const _keyRole = 'active_family_role';
  static const _keyMariaEnabled = 'maria_enabled';
  static const _keyMariaApiKey = 'maria_api_key';
  static const _keyMariaModel = 'maria_model';
  static const _keyLocale = 'app_locale';

  int? _activeFamilyId;
  String? _activeFamilyName;
  String _accentColorHex = FamyliaAccentPresets.defaultHex;
  FamilyRole? _role;
  bool _mariaEnabled = false;
  String _mariaApiKey = '';
  String _mariaModel = 'claude-sonnet-4-6';
  String _locale = 'it';

  int? get activeFamilyId => _activeFamilyId;
  String? get activeFamilyName => _activeFamilyName;
  String get accentColorHex => _accentColorHex;
  FamilyRole? get role => _role;
  bool get hasActiveFamily => _activeFamilyId != null;
  bool get isAdmin => _role == FamilyRole.admin;

  /// MarIA Premium
  bool get hasMarIA => _mariaEnabled;
  String get mariaApiKey => _mariaApiKey;
  String get mariaModel => _mariaModel;

  /// Lingua app ('it' | 'en')
  String get locale => _locale;

  Future<void> load() async {
    _activeFamilyId = _prefs.getInt(_keyActiveFamilyId);
    _activeFamilyName = _prefs.getString(_keyActiveFamilyName);
    _accentColorHex =
        _prefs.getString(_keyAccentColor) ?? FamyliaAccentPresets.defaultHex;
    final roleName = _prefs.getString(_keyRole);
    _role = roleName != null ? FamilyRole.fromJson(roleName) : null;
    _mariaEnabled = _prefs.getBool(_keyMariaEnabled) ?? false;
    _mariaApiKey = _prefs.getString(_keyMariaApiKey) ?? '';
    _mariaModel = _prefs.getString(_keyMariaModel) ?? 'claude-sonnet-4-6';
    _locale = _prefs.getString(_keyLocale) ?? 'it';
    notifyListeners();
    if (_activeFamilyId != null) {
      await refreshFromServer();
    }
  }

  Future<void> activateMarIA() async {
    _mariaEnabled = true;
    await _prefs.setBool(_keyMariaEnabled, true);
    notifyListeners();
  }

  Future<void> deactivateMarIA() async {
    _mariaEnabled = false;
    await _prefs.setBool(_keyMariaEnabled, false);
    notifyListeners();
  }

  Future<void> saveMarIAConfig({required String apiKey, required String model}) async {
    _mariaApiKey = apiKey;
    _mariaModel = model;
    await _prefs.setString(_keyMariaApiKey, apiKey);
    await _prefs.setString(_keyMariaModel, model);
    notifyListeners();
  }

  Future<void> setLocale(String languageCode) async {
    _locale = languageCode;
    await _prefs.setString(_keyLocale, languageCode);
    notifyListeners();
  }

  Future<void> setActiveFamily({
    required int id,
    required String name,
    String? accentColor,
    FamilyRole? role,
  }) async {
    _activeFamilyId = id;
    _activeFamilyName = name;
    if (accentColor != null) _accentColorHex = accentColor;
    if (role != null) _role = role;
    await _prefs.setInt(_keyActiveFamilyId, id);
    await _prefs.setString(_keyActiveFamilyName, name);
    await _prefs.setString(_keyAccentColor, _accentColorHex);
    if (_role != null) {
      await _prefs.setString(_keyRole, _role!.toJson());
    }
    notifyListeners();
    await refreshFromServer();
  }

  Future<void> refreshFromServer() async {
    final id = _activeFamilyId;
    if (id == null) return;
    try {
      final family = await _families.getFamily(id);
      _accentColorHex = family.accentColor ?? FamyliaAccentPresets.defaultHex;
      await _prefs.setString(_keyAccentColor, _accentColorHex);

      final mine = await _families.listMyFamilies();
      for (final f in mine) {
        if (f.family.id == id) {
          _role = f.role;
          await _prefs.setString(_keyRole, _role!.toJson());
          break;
        }
      }
      notifyListeners();
    } catch (_) {
      // Mantieni valori in cache se offline.
    }
  }

  Future<void> setAccentColor(String hex) async {
    _accentColorHex = hex;
    await _prefs.setString(_keyAccentColor, hex);
    notifyListeners();
  }

  Future<void> clear() async {
    _activeFamilyId = null;
    _activeFamilyName = null;
    _accentColorHex = FamyliaAccentPresets.defaultHex;
    _role = null;
    await _prefs.remove(_keyActiveFamilyId);
    await _prefs.remove(_keyActiveFamilyName);
    await _prefs.remove(_keyAccentColor);
    await _prefs.remove(_keyRole);
    notifyListeners();
  }
}
