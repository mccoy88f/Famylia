import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/feed/feed_screen.dart';
import '../../features/lista/lista_screen.dart';
import '../../features/agenda/agenda_screen.dart';
import '../../features/altro/altro_screen.dart';
import '../../features/onboarding/create_family_screen.dart';
import '../../features/onboarding/join_family_screen.dart';
import '../../features/onboarding/onboarding_hub_screen.dart';
import '../../features/shopping/shopping_list_detail_screen.dart';
import '../../features/shell/app_shell.dart';
import '../../features/board/board_screen.dart';
import '../../features/calendar/calendar_screen.dart';
import '../../features/deadlines/deadlines_screen.dart';
import '../../features/documents/documents_screen.dart';
import '../../features/expenses/expense_balance_screen.dart';
import '../../features/expenses/expenses_screen.dart';
import '../../features/gamification/leaderboard_screen.dart';
import '../../features/emergency/emergency_screen.dart';
import '../../features/location/location_screen.dart';
import '../../features/health/health_screen.dart';
import '../../features/settings/family_appearance_screen.dart';
import '../../features/meals/meals_screen.dart';
import '../../features/privacy/privacy_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/ai/ai_import_screen.dart';
import '../../features/ai/ai_admin_screen.dart';
import '../session/app_state.dart';
import '../session/family_context.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const createFamily = '/onboarding/create';
  static const joinFamily = '/onboarding/join';
  // Shell tabs
  static const feed = '/feed';
  static const lista = '/lista';
  static const agenda = '/agenda';
  static const altro = '/altro';
  // Legacy shortcuts (remain outside shell for deep links)
  static const home = '/feed';
  static const todos = '/lista';
  static const shopping = '/lista';
  // Detail screens
  static const deadlines = '/deadlines';
  static const expenses = '/expenses';
  static const expenseBalance = '/expenses/balance';
  static const calendar = '/calendar';
  static const board = '/board';
  static const documents = '/documents';
  static const meals = '/meals';
  static const health = '/health';
  static const appearance = '/settings/appearance';
  static String mealsWithDiet(int dietId) => '/meals?dietId=$dietId';
  static const privacy = '/privacy';
  static const location = '/location';
  static const emergency = '/emergency';
  static const reports = '/reports';
  static const leaderboard = '/leaderboard';
  static const aiImport = '/ai/import';
  static const aiAdmin = '/ai/admin';
  static String shoppingList(int id) => '/shopping/$id';
}

GoRouter createAppRouter({
  required AppState appState,
  required FamilyContext familyContext,
}) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: Listenable.merge([appState, familyContext]),
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final isAuthRoute = loc == AppRoutes.login || loc == AppRoutes.register;

      if (!appState.isSignedIn) {
        return isAuthRoute ? null : AppRoutes.login;
      }
      if (!familyContext.hasActiveFamily) {
        final isOnboarding = loc.startsWith('/onboarding');
        return isOnboarding ? null : AppRoutes.onboarding;
      }
      if (isAuthRoute || loc.startsWith('/onboarding')) {
        return AppRoutes.feed;
      }
      if (loc == '/' || loc == '/home' || loc == '/todos' || loc == '/shopping') {
        return AppRoutes.feed;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.register, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (_, __) => const OnboardingHubScreen()),
      GoRoute(path: AppRoutes.createFamily, builder: (_, __) => const CreateFamilyScreen()),
      GoRoute(path: AppRoutes.joinFamily, builder: (_, __) => const JoinFamilyScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.feed, builder: (_, __) => const FeedScreen()),
          GoRoute(
            path: AppRoutes.lista,
            builder: (_, state) {
              final tab = state.extra == 'shopping' ? 1 : 0;
              return ListaScreen(initialTab: tab);
            },
          ),
          GoRoute(path: AppRoutes.agenda, builder: (_, __) => const AgendaScreen()),
          GoRoute(path: AppRoutes.altro, builder: (_, __) => const AltroScreen()),
        ],
      ),
      GoRoute(
        path: '/shopping/:listId',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['listId']!);
          return ShoppingListDetailScreen(listId: id);
        },
      ),
      GoRoute(path: AppRoutes.deadlines, builder: (_, __) => const DeadlinesScreen()),
      GoRoute(path: AppRoutes.expenses, builder: (_, __) => const ExpensesScreen()),
      GoRoute(path: AppRoutes.expenseBalance, builder: (_, __) => const ExpenseBalanceScreen()),
      GoRoute(path: AppRoutes.calendar, builder: (_, __) => const CalendarScreen()),
      GoRoute(path: AppRoutes.board, builder: (_, __) => const BoardScreen()),
      GoRoute(path: AppRoutes.documents, builder: (_, __) => const DocumentsScreen()),
      GoRoute(
        path: AppRoutes.meals,
        builder: (context, state) {
          final dietId = int.tryParse(state.uri.queryParameters['dietId'] ?? '');
          return MealsScreen(linkedDietId: dietId);
        },
      ),
      GoRoute(path: AppRoutes.appearance, builder: (_, __) => const FamilyAppearanceScreen()),
      GoRoute(path: AppRoutes.health, builder: (_, __) => const HealthScreen()),
      GoRoute(path: AppRoutes.privacy, builder: (_, __) => const PrivacyScreen()),
      GoRoute(path: AppRoutes.location, builder: (_, __) => const LocationScreen()),
      GoRoute(path: AppRoutes.emergency, builder: (_, __) => const EmergencyScreen()),
      GoRoute(path: AppRoutes.reports, builder: (_, __) => const ReportsScreen()),
      GoRoute(path: AppRoutes.leaderboard, builder: (_, __) => const LeaderboardScreen()),
      GoRoute(path: AppRoutes.aiImport, builder: (_, __) => const AiImportScreen()),
      GoRoute(path: AppRoutes.aiAdmin, builder: (_, __) => const AiAdminScreen()),
    ],
  );
}
