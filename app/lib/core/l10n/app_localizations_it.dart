import 'app_localizations.dart';

class AppLocalizationsIt extends AppLocalizations {
  const AppLocalizationsIt();

  // ── Auth ──────────────────────────────────────────────────────────────────
  @override String get loginSubtitle => 'Bentornato/a in famiglia 👋';
  @override String get loginEmailError => 'Hmm, questa email non ci convince';
  @override String get loginPasswordError => 'La password è troppo corta (min. 8 caratteri)';
  @override String get loginConnectionError => 'Impossibile connettersi — il server è acceso?';
  @override String get loginButton => 'Accedi';
  @override String get loginNoAccount => 'Non hai un account? Registrati';

  @override String get registerTitle => 'Crea il tuo account';
  @override String get registerNameError => 'Come ti chiami? Il nome è obbligatorio';
  @override String get registerEmailError => 'Questa email non sembra giusta';
  @override String get registerPasswordError => 'La password è troppo corta (min. 8 caratteri)';
  @override String get registerSendCode => 'Manda il codice →';
  @override String get registerEnter => 'Entra in famiglia 🏠';
  @override String get registerCodeError => 'Inserisci il codice che ti abbiamo mandato';

  // ── Onboarding ────────────────────────────────────────────────────────────
  @override String get onboardingTitle => 'Chi c\'è in famiglia?';
  @override String get onboardingSubtitle => 'Crea un nuovo gruppo famiglia o unisciti a chi ti ha già invitato.';
  @override String get onboardingCreate => 'Crea la mia famiglia';
  @override String get onboardingJoin => 'Sono stato/a invitato/a';

  // ── Feed / Home ───────────────────────────────────────────────────────────
  @override String greetingName(String name) => 'Ciao, $name 👋';
  @override String get nothingToDo => 'Niente da fare oggi 🎉 Goditi il meritato relax!';

  // ── Task ─────────────────────────────────────────────────────────────────
  @override String get taskAddedSnack => 'Aggiunto alla lista ✓';
  @override String get taskDoneSnack => 'Ottimo lavoro! ✅';
  @override String taskPointsSnack(int points) => '+$points pt guadagnati 🌟';
  @override String get taskAnyone => 'Chiunque può farlo';
  @override String get taskEveryone => 'Tutti';
  @override String get taskHintText => 'Cosa c\'è da fare?';

  // ── Shopping ─────────────────────────────────────────────────────────────
  @override String get shoppingNoLists => 'Nessuna lista ancora — creane una!';
  @override String get shoppingNeedList => 'Prima crea una lista della spesa 😉';
  @override String get shoppingItemHint => 'Cosa manca? 🛒';
  @override String get shoppingItemAdded => 'Aggiunto alla lista ✓';
  @override String get shoppingListCreatedAndAdded => 'Lista creata e articolo aggiunto ✓';
  @override String shoppingAddedToList(String name) => 'Aggiunto a "$name" ✓';

  // ── Board ─────────────────────────────────────────────────────────────────
  @override String get boardMessageHint => 'Cosa vuoi dire alla famiglia?';
  @override String get boardMessageSent => 'Messaggio inviato ✓';

  // ── Gamification ──────────────────────────────────────────────────────────
  @override String get leaderboardTitle => 'Chi è il più in gamba? 🏆';
  @override String get leaderboardMyPoints => 'I tuoi punti 🌟';
  @override String get leaderboardEmpty => 'Nessun punto ancora — completa qualcosa e scala la classifica! 🚀';

  // ── Errors ────────────────────────────────────────────────────────────────
  @override String get errorGeneric => 'Qualcosa è andato storto 😕 Riprova';
  @override String get errorPhotoTooBigCover => 'Foto troppo grande! Usa un\'immagine sotto 800 KB';
  @override String get errorPhotoTooBigProfile => 'Foto troppo grande! Prova con una sotto 400 KB';

  // ── MarIA ─────────────────────────────────────────────────────────────────
  @override String get mariaName => 'MarIA';
  @override String get mariaRole => 'Assistente familiare AI';
  @override String get mariaPremiumTitle => 'Famylia Premium · MarIA';
  @override String get mariaPremiumSubtitle => 'Il tuo assistente familiare intelligente, sempre con voi.';
  @override String get mariaPremiumActivate => 'Attiva MarIA';
  @override String get mariaPremiumActive => 'MarIA è attiva ✓';
  @override String get mariaPremiumManage => 'Gestisci abbonamento';
  @override String get mariaUpsellTitle => 'Scopri MarIA ✨';
  @override String get mariaUpsellBody => 'Con MarIA Premium hai un assistente familiare AI sempre disponibile: aggiunge task, intercetta scadenze e ti aiuta a gestire tutto.';
  @override String get mariaUpsellButton => 'Attiva MarIA — è gratis per ora!';
  @override String get mariaSettingsApiKey => 'API Key AI';
  @override String get mariaSettingsApiKeyHint => 'sk-ant-...';
  @override String get mariaSettingsModel => 'Modello AI';
  @override String get mariaSettingsSave => 'Salva configurazione';
  @override String get mariaSettingsSaved => 'Configurazione salvata ✓';
  @override String get mariaFeature1 => '📋 Aggiunge task da testo, foto e email';
  @override String get mariaFeature2 => '📅 Intercetta appuntamenti e scadenze';
  @override String get mariaFeature3 => '🛒 Suggerisce cosa manca dalla spesa';
  @override String get mariaFeature4 => '💬 Risponde alle domande della famiglia';
}
