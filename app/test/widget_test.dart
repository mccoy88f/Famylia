import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:famylia_app/core/session/family_context.dart';
import 'package:famylia_app/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FamilyContext persiste famiglia attiva', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final ctx = FamilyContext(prefs);

    await ctx.setActiveFamily(id: 42, name: 'Test');
    expect(ctx.activeFamilyId, 42);
    expect(ctx.activeFamilyName, 'Test');
    expect(ctx.hasActiveFamily, isTrue);

    final ctx2 = FamilyContext(prefs);
    await ctx2.load();
    expect(ctx2.activeFamilyId, 42);
  });

  test('AppTheme light e dark sono definiti', () {
    expect(AppTheme.light().brightness, Brightness.light);
    expect(AppTheme.dark().brightness, Brightness.dark);
  });
}
