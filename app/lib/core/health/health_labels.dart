import 'package:famylia_client/famylia_client.dart';

abstract final class HealthLabels {
  static String type(HealthEntryType t) => switch (t) {
        HealthEntryType.medicalVisit => 'Visita medica',
        HealthEntryType.diet => 'Dieta',
        HealthEntryType.sportActivity => 'Sport',
      };

  static String status(HealthEntryStatus s) => switch (s) {
        HealthEntryStatus.active => 'Attiva',
        HealthEntryStatus.planned => 'Pianificata',
        HealthEntryStatus.completed => 'Completata',
        HealthEntryStatus.cancelled => 'Annullata',
      };

  static String intensity(SportIntensity i) => switch (i) {
        SportIntensity.low => 'Leggera',
        SportIntensity.medium => 'Media',
        SportIntensity.high => 'Intensa',
      };
}
