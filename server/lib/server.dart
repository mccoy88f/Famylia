import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'src/util/dev_verification_codes.dart';

/// Avvia il server Famylia.
void run(List<String> args) async {
  auth.AuthConfig.set(
    auth.AuthConfig(
      minPasswordLength: 8,
      maxAllowedEmailSignInAttempts: 5,
      // Sviluppo: stampa il codice verifica in console (configura SMTP in produzione).
      sendValidationEmail: (session, email, validationCode) async {
        DevVerificationCodes.put(email, validationCode);
        session.log(
          'Famylia — codice verifica per $email: $validationCode',
          level: LogLevel.warning,
        );
        return true;
      },
    ),
  );

  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  await pod.start();
}
