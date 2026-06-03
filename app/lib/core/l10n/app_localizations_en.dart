import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  const AppLocalizationsEn();

  // ── Auth ──────────────────────────────────────────────────────────────────
  @override String get loginSubtitle => 'Welcome back to your family 👋';
  @override String get loginEmailError => 'Hmm, that email doesn\'t look right';
  @override String get loginPasswordError => 'Password is too short (min. 8 characters)';
  @override String get loginConnectionError => 'Can\'t connect — is the server running?';
  @override String get loginButton => 'Sign in';
  @override String get loginNoAccount => 'No account yet? Sign up';

  @override String get registerTitle => 'Create your account';
  @override String get registerNameError => 'What\'s your name? It\'s required';
  @override String get registerEmailError => 'That email doesn\'t look right';
  @override String get registerPasswordError => 'Password is too short (min. 8 characters)';
  @override String get registerSendCode => 'Send verification code →';
  @override String get registerEnter => 'Join the family 🏠';
  @override String get registerCodeError => 'Enter the code we sent you';

  // ── Onboarding ────────────────────────────────────────────────────────────
  @override String get onboardingTitle => 'Who\'s in your family?';
  @override String get onboardingSubtitle => 'Create a new family group or join one you\'ve been invited to.';
  @override String get onboardingCreate => 'Create my family';
  @override String get onboardingJoin => 'I\'ve been invited';

  // ── Feed / Home ───────────────────────────────────────────────────────────
  @override String greetingName(String name) => 'Hey, $name 👋';
  @override String get nothingToDo => 'Nothing to do today 🎉 Enjoy your well-earned rest!';

  // ── Task ─────────────────────────────────────────────────────────────────
  @override String get taskAddedSnack => 'Added to the list ✓';
  @override String get taskDoneSnack => 'Great job! ✅';
  @override String taskPointsSnack(int points) => '+$points pts earned 🌟';
  @override String get taskAnyone => 'Anyone can do it';
  @override String get taskEveryone => 'Everyone';
  @override String get taskHintText => 'What needs doing?';

  // ── Shopping ─────────────────────────────────────────────────────────────
  @override String get shoppingNoLists => 'No lists yet — create one!';
  @override String get shoppingNeedList => 'Create a shopping list first 😉';
  @override String get shoppingItemHint => 'What\'s missing? 🛒';
  @override String get shoppingItemAdded => 'Added to the list ✓';
  @override String get shoppingListCreatedAndAdded => 'List created and item added ✓';
  @override String shoppingAddedToList(String name) => 'Added to "$name" ✓';

  // ── Board ─────────────────────────────────────────────────────────────────
  @override String get boardMessageHint => 'What do you want to tell the family?';
  @override String get boardMessageSent => 'Message sent ✓';

  // ── Gamification ──────────────────────────────────────────────────────────
  @override String get leaderboardTitle => 'Who\'s the top performer? 🏆';
  @override String get leaderboardMyPoints => 'Your points 🌟';
  @override String get leaderboardEmpty => 'No points yet — complete something and climb the leaderboard! 🚀';

  // ── Errors ────────────────────────────────────────────────────────────────
  @override String get errorGeneric => 'Something went wrong 😕 Please try again';
  @override String get errorPhotoTooBigCover => 'Photo too large! Use an image under 800 KB';
  @override String get errorPhotoTooBigProfile => 'Photo too large! Try one under 400 KB';

  // ── MarIA ─────────────────────────────────────────────────────────────────
  @override String get mariaName => 'MarIA';
  @override String get mariaRole => 'AI Family Assistant';
  @override String get mariaPremiumTitle => 'Famylia Premium · MarIA';
  @override String get mariaPremiumSubtitle => 'Your intelligent family assistant, always there for you.';
  @override String get mariaPremiumActivate => 'Activate MarIA';
  @override String get mariaPremiumActive => 'MarIA is active ✓';
  @override String get mariaPremiumManage => 'Manage subscription';
  @override String get mariaUpsellTitle => 'Meet MarIA ✨';
  @override String get mariaUpsellBody => 'With MarIA Premium you get an AI family assistant always available: she adds tasks, catches deadlines and helps you manage everything.';
  @override String get mariaUpsellButton => 'Activate MarIA — free for now!';
  @override String get mariaSettingsApiKey => 'AI API Key';
  @override String get mariaSettingsApiKeyHint => 'sk-ant-...';
  @override String get mariaSettingsModel => 'AI Model';
  @override String get mariaSettingsSave => 'Save configuration';
  @override String get mariaSettingsSaved => 'Configuration saved ✓';
  @override String get mariaFeature1 => '📋 Adds tasks from text, photos and emails';
  @override String get mariaFeature2 => '📅 Catches appointments and deadlines';
  @override String get mariaFeature3 => '🛒 Suggests what\'s missing from the shopping list';
  @override String get mariaFeature4 => '💬 Answers the family\'s questions';
}
