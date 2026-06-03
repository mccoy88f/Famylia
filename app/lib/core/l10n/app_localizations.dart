import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations_it.dart';
import 'app_localizations_en.dart';

/// Accesso alle stringhe localizzate.
/// Uso: AppLocalizations.of(context).loginTitle
abstract class AppLocalizations {
  const AppLocalizations();

  static AppLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'en') return const AppLocalizationsEn();
    return const AppLocalizationsIt();
  }

  static const List<Locale> supportedLocales = [
    Locale('it'),
    Locale('en'),
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // ── Auth ──────────────────────────────────────────────────────────────────
  String get loginSubtitle;
  String get loginEmailError;
  String get loginPasswordError;
  String get loginConnectionError;
  String get loginButton;
  String get loginNoAccount;

  String get registerTitle;
  String get registerNameError;
  String get registerEmailError;
  String get registerPasswordError;
  String get registerSendCode;
  String get registerEnter;
  String get registerCodeError;

  // ── Onboarding ────────────────────────────────────────────────────────────
  String get onboardingTitle;
  String get onboardingSubtitle;
  String get onboardingCreate;
  String get onboardingJoin;

  // ── Feed / Home ───────────────────────────────────────────────────────────
  String greetingName(String name);
  String get nothingToDo;

  // ── Task ─────────────────────────────────────────────────────────────────
  String get taskAddedSnack;
  String get taskDoneSnack;
  String taskPointsSnack(int points);
  String get taskAnyone;
  String get taskEveryone;
  String get taskHintText;

  // ── Shopping ─────────────────────────────────────────────────────────────
  String get shoppingNoLists;
  String get shoppingNeedList;
  String get shoppingItemHint;
  String get shoppingItemAdded;
  String get shoppingListCreatedAndAdded;
  String shoppingAddedToList(String name);

  // ── Board ─────────────────────────────────────────────────────────────────
  String get boardMessageHint;
  String get boardMessageSent;

  // ── Gamification ──────────────────────────────────────────────────────────
  String get leaderboardTitle;
  String get leaderboardMyPoints;
  String get leaderboardEmpty;

  // ── Errors ────────────────────────────────────────────────────────────────
  String get errorGeneric;
  String get errorPhotoTooBigCover;
  String get errorPhotoTooBigProfile;

  // ── MarIA ─────────────────────────────────────────────────────────────────
  String get mariaName;
  String get mariaRole;
  String get mariaPremiumTitle;
  String get mariaPremiumSubtitle;
  String get mariaPremiumActivate;
  String get mariaPremiumActive;
  String get mariaPremiumManage;
  String get mariaUpsellTitle;
  String get mariaUpsellBody;
  String get mariaUpsellButton;
  String get mariaSettingsApiKey;
  String get mariaSettingsApiKeyHint;
  String get mariaSettingsModel;
  String get mariaSettingsSave;
  String get mariaSettingsSaved;
  String get mariaFeature1;
  String get mariaFeature2;
  String get mariaFeature3;
  String get mariaFeature4;
}
