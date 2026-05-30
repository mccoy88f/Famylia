import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/famylia_services.dart';
import 'core/shopping/shopping_offline_store.dart';
import 'core/sync/connectivity_sync.dart';
import 'core/router/app_router.dart';
import 'core/session/app_state.dart';
import 'core/session/family_context.dart';
import 'core/theme/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await ShoppingOfflineStore.instance.init();
  await FamyliaServices.init();

  final prefs = await SharedPreferences.getInstance();
  final familyContext = FamilyContext(prefs);
  await familyContext.load();
  final appSettings = AppSettings(prefs);
  await appSettings.load();

  final appState = AppState();

  final router = createAppRouter(
    appState: appState,
    familyContext: familyContext,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        ChangeNotifierProvider.value(value: familyContext),
        ChangeNotifierProvider.value(value: appSettings),
      ],
      child: FamyliaApp(
        router: router,
        familyContext: familyContext,
        appSettings: appSettings,
      ),
    ),
  );
}

class FamyliaApp extends StatefulWidget {
  const FamyliaApp({
    required this.router,
    required this.familyContext,
    required this.appSettings,
    super.key,
  });

  final GoRouter router;
  final FamilyContext familyContext;
  final AppSettings appSettings;

  @override
  State<FamyliaApp> createState() => _FamyliaAppState();
}

class _FamyliaAppState extends State<FamyliaApp> {
  late final ConnectivitySync _connectivitySync;

  @override
  void initState() {
    super.initState();
    _connectivitySync = ConnectivitySync(familyContext: widget.familyContext)
      ..start();
  }

  @override
  void dispose() {
    _connectivitySync.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.familyContext,
        widget.appSettings,
      ]),
      builder: (context, _) {
        return ShadApp.router(
          title: 'Famylia',
          debugShowCheckedModeBanner: false,
          themeMode: widget.appSettings.themeMode,
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadZincColorScheme.light(),
          ),
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadZincColorScheme.dark(),
          ),
          routerConfig: widget.router,
        );
      },
    );
  }
}
