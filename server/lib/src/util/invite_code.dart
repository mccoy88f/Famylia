import 'dart:math';

/// Genera un codice invito famiglia leggibile (es. `FAM-A3K9X2`).
String generateInviteCode() {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  final random = Random.secure();
  final buffer = StringBuffer('FAM-');
  for (var i = 0; i < 6; i++) {
    buffer.write(chars[random.nextInt(chars.length)]);
  }
  return buffer.toString();
}
