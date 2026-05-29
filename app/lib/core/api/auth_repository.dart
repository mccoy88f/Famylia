import 'package:famylia_client/famylia_client.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'famylia_services.dart';

/// Autenticazione email/password via Serverpod Auth.
class AuthRepository {
  AuthRepository({FamyliaServices? services})
      : _services = services ?? FamyliaServices.instance;

  final FamyliaServices _services;

  Client get _client => _services.client;
  SessionManager get _session => _services.sessionManager;

  /// Login con email e password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.modules.auth.email.authenticate(
      email.trim().toLowerCase(),
      password,
    );
    await _applyAuthResponse(response);
  }

  /// Richiede creazione account (in dev il codice non arriva via email).
  Future<void> requestAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    final ok = await _client.modules.auth.email.createAccountRequest(
      userName.trim(),
      email.trim().toLowerCase(),
      password,
    );
    if (!ok) {
      throw AuthException('Impossibile creare l\'account. Email già in uso?');
    }
  }

  /// In sviluppo: recupera il codice mostrato dal server (nessuna email reale).
  Future<String?> devVerificationCode(String email) async {
    try {
      return await _client.dev.getVerificationCode(email);
    } catch (_) {
      return null;
    }
  }

  /// Completa registrazione con codice di verifica.
  Future<void> completeAccount({
    required String email,
    required String verificationCode,
    required String password,
  }) async {
    final user = await _client.modules.auth.email.createAccount(
      email.trim().toLowerCase(),
      verificationCode.trim(),
    );
    if (user == null) {
      throw AuthException('Codice di verifica non valido.');
    }
    await signInWithEmail(email: email, password: password);
  }

  Future<void> signOut() async {
    await _session.signOutDevice();
  }

  Future<void> _applyAuthResponse(AuthenticationResponse response) async {
    if (!response.success ||
        response.userInfo == null ||
        response.key == null ||
        response.keyId == null) {
      throw AuthException(_messageForFailReason(response.failReason));
    }
    await _session.registerSignedInUser(
      response.userInfo!,
      response.keyId!,
      response.key!,
    );
  }

  String _messageForFailReason(AuthenticationFailReason? reason) {
    return switch (reason) {
      AuthenticationFailReason.invalidCredentials => 'Email o password non corretti.',
      AuthenticationFailReason.tooManyFailedAttempts =>
        'Troppi tentativi. Riprova tra qualche minuto.',
      AuthenticationFailReason.internalError => 'Errore del server. Riprova.',
      _ => 'Accesso non riuscito.',
    };
  }
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
