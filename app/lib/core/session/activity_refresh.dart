import 'package:flutter/foundation.dart';

/// Segnala che attività (spese, scadenze, calendario, …) sono cambiate altrove.
class ActivityRefresh extends ChangeNotifier {
  ActivityRefresh._();
  static final instance = ActivityRefresh._();

  void notifyChanged() => notifyListeners();
}
