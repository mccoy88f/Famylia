// Smoke test end-to-end Famylia (server su :8080, log codice verifica in dev).
// dart run smoke_test.dart

import 'dart:io';

import 'package:famylia_client/famylia_client.dart';
import 'package:serverpod_client/serverpod_client.dart';

Future<void> main() async {
  final keyManager = _MemoryKeyManager();
  final client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: keyManager,
  );

  final stamp = DateTime.now().millisecondsSinceEpoch;
  final email = 'smoke_$stamp@famylia.local';
  const password = 'testpass123';
  const userName = 'Smoke Test';

  stdout.writeln('==> 1. Registrazione ($email)');
  final requested = await client.modules.auth.email.createAccountRequest(
    userName,
    email,
    password,
  );
  if (!requested) throw StateError('createAccountRequest fallito');

  await Future<void>.delayed(const Duration(milliseconds: 500));
  final code = _readVerificationCodeFromServerLog(email);
  if (code == null) {
    throw StateError(
      'Codice verifica non trovato nei log. Controlla output server.',
    );
  }
  stdout.writeln('    Codice verifica: $code');

  stdout.writeln('==> 2. Completa account');
  final user = await client.modules.auth.email.createAccount(email, code);
  if (user == null) throw StateError('createAccount fallito');

  stdout.writeln('==> 3. Login');
  final auth = await client.modules.auth.email.authenticate(email, password);
  if (!auth.success || auth.key == null || auth.keyId == null) {
    throw StateError('authenticate fallito: ${auth.failReason}');
  }
  await keyManager.put('${auth.keyId}:${auth.key}');

  stdout.writeln('==> 4. Crea famiglia');
  final family = await client.family.createFamily('Famiglia Smoke $stamp');
  stdout.writeln('    Famiglia: ${family.name} (${family.inviteCode})');

  stdout.writeln('==> 5. Elenco famiglie');
  final list = await client.family.listMyFamilies();
  stdout.writeln('    ${list.length} famiglia/e');
  final familyId = family.id!;

  stdout.writeln('==> 6. Todo');
  final todo = await client.todo.createTodo(
    familyId,
    'Comprare latte',
    priority: TodoPriority.medium,
  );
  await client.todo.completeTodo(todo.id!);
  final todos = await client.todo.listTodos(familyId);
  stdout.writeln('    ${todos.length} task');

  stdout.writeln('==> 7. Lista spesa');
  final shopList = await client.shopping.createList(
    familyId,
    'Spesa settimanale',
    store: 'Supermercato',
  );
  await client.shopping.addItem(shopList.id!, 'Pane');
  await client.shopping.addItem(shopList.id!, 'Latte');
  final detail = await client.shopping.getList(shopList.id!);
  stdout.writeln('    ${detail.items.length} articoli');

  stdout.writeln('==> 8. Membri con nome');
  final members = await client.family.listMembers(familyId);
  final userId = members.first.userId;
  stdout.writeln('    ${members.map((m) => m.displayName).join(', ')}');

  stdout.writeln('==> 9. Scadenze');
  final dl = await client.deadline.createDeadline(
    familyId,
    'Bolletta luce',
    DateTime.now().add(const Duration(days: 14)),
    amount: 89.5,
    category: DeadlineCategory.bill,
  );
  await client.deadline.completeDeadline(dl.id!);
  stdout.writeln('    scadenza completata');

  stdout.writeln('==> 10. Spese e bilancio');
  await client.expense.createExpense(
    familyId,
    'Cena fuori',
    60,
    userId,
    category: ExpenseCategory.entertainment,
  );
  final balance = await client.expense.getBalance(familyId);
  stdout.writeln('    ${balance.members.length} saldi, ${balance.suggestions.length} suggerimenti');

  stdout.writeln('==> 11. Calendario');
  await client.calendar.createEvent(
    familyId,
    'Riunione scuola',
    DateTime.now().add(const Duration(days: 3)),
    category: CalendarEventCategory.school,
  );
  final events = await client.calendar.listEvents(
    familyId,
    DateTime.now(),
    DateTime.now().add(const Duration(days: 30)),
  );
  stdout.writeln('    ${events.length} eventi');

  stdout.writeln('==> 12. Bacheca');
  await client.board.createPost(familyId, 'Benvenuti in Famylia!');
  final posts = await client.board.listPosts(familyId);
  stdout.writeln('    ${posts.length} post');

  stdout.writeln('==> 13. Meal planner');
  await client.meal.createRecipe(familyId, 'Pasta');
  final week = DateTime.now();
  await client.meal.saveMealPlan(
    familyId,
    DateTime.utc(week.year, week.month, week.day),
    '[{"day":"lun","ingredients":["pasta","pomodoro"]}]',
  );
  final ingredients = await client.meal.shoppingItemsFromPlan(
    familyId,
    DateTime.utc(week.year, week.month, week.day),
  );
  stdout.writeln('    ${ingredients.length} ingredienti da piano');

  stdout.writeln('==> 14. Salute');
  await client.health.createEntry(
    familyId,
    HealthEntryType.medicalVisit,
    'Visita pediatrica',
    scheduledAt: DateTime.now().add(const Duration(days: 5)),
    providerName: 'Dr. Rossi',
  );
  await client.health.createEntry(
    familyId,
    HealthEntryType.diet,
    'Dieta mediterranea',
    dietGoal: 'Equilibrio',
    caloriesTarget: 2000,
  );
  await client.health.createEntry(
    familyId,
    HealthEntryType.sportActivity,
    'Corsa',
    scheduledAt: DateTime.now().add(const Duration(days: 2)),
    sportType: 'Running',
    durationMinutes: 45,
    intensity: SportIntensity.medium,
  );
  final healthItems = await client.health.listEntries(familyId);
  stdout.writeln('    ${healthItems.length} voci salute');

  stdout.writeln('==> 15. GDPR export');
  final gdpr = await client.gdpr.exportMyData();
  stdout.writeln('    export ${gdpr.payloadJson.length} chars');

  stdout.writeln('==> 16. Location');
  await client.location.updateStatus(familyId, true);
  await client.location.checkIn(familyId, 45.46, 9.19, address: 'Milano');
  final locs = await client.location.getFamilyLocations(familyId);
  stdout.writeln('    ${locs.length} posizioni famiglia');

  stdout.writeln('==> 17. Emergenza (test)');
  await client.emergency.triggerAlert(
    familyId,
    EmergencyAlertType.medical,
    isTest: true,
    customMessage: 'Smoke test',
  );
  final active = await client.emergency.listActive(familyId);
  stdout.writeln('    ${active.length} allerte attive');

  stdout.writeln('==> 18. Gamification');
  final points = await client.gamification.getMyPoints(familyId);
  stdout.writeln('    ${points.points} punti');

  stdout.writeln('==> 19. Report');
  final report = await client.report.getReport(familyId);
  stdout.writeln('    spese €${report.totalExpenses.toStringAsFixed(2)}');

  stdout.writeln('');
  stdout.writeln('✅ Smoke test OK (Fase 1–3 + Salute)');
}

String? _readVerificationCodeFromServerLog(String email) {
  final pattern = RegExp(
    'codice verifica per ${RegExp.escape(email)}:\\s*(\\S+)',
  );

  // Cerca in tutti i terminal log recenti
  final termDir = Directory(
    '${Platform.environment['HOME']}/.cursor/projects/home-antonello-Sviluppo-Famylia/terminals',
  );
  if (termDir.existsSync()) {
    for (final f in termDir.listSync().whereType<File>()) {
      final m = pattern.firstMatch(f.readAsStringSync());
      if (m != null) return m.group(1);
    }
  }
  return null;
}

class _MemoryKeyManager extends AuthenticationKeyManager {
  String? _key;

  @override
  Future<String?> get() async => _key;

  @override
  Future<void> put(String key) async => _key = key;

  @override
  Future<void> remove() async => _key = null;
}
