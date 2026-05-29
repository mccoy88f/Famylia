import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/dev_verification_codes.dart';

/// Endpoint solo per sviluppo locale (codice verifica senza email).
class DevEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<String?> getVerificationCode(Session session, String email) async {
    if (session.serverpod.runMode != ServerpodRunMode.development) {
      throw FamyliaException(
        message: 'Codice dev non disponibile in questo ambiente.',
      );
    }
    return DevVerificationCodes.peek(email);
  }
}
