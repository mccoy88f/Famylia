import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Famiglia attualmente selezionata (multi-famiglia).
class FamilyContext extends ChangeNotifier {
  FamilyContext(this._prefs);

  final SharedPreferences _prefs;
  static const _keyActiveFamilyId = 'active_family_id';
  static const _keyActiveFamilyName = 'active_family_name';

  int? _activeFamilyId;
  String? _activeFamilyName;

  int? get activeFamilyId => _activeFamilyId;
  String? get activeFamilyName => _activeFamilyName;
  bool get hasActiveFamily => _activeFamilyId != null;

  Future<void> load() async {
    _activeFamilyId = _prefs.getInt(_keyActiveFamilyId);
    _activeFamilyName = _prefs.getString(_keyActiveFamilyName);
    notifyListeners();
  }

  Future<void> setActiveFamily({required int id, required String name}) async {
    _activeFamilyId = id;
    _activeFamilyName = name;
    await _prefs.setInt(_keyActiveFamilyId, id);
    await _prefs.setString(_keyActiveFamilyName, name);
    notifyListeners();
  }

  Future<void> clear() async {
    _activeFamilyId = null;
    _activeFamilyName = null;
    await _prefs.remove(_keyActiveFamilyId);
    await _prefs.remove(_keyActiveFamilyName);
    notifyListeners();
  }
}
