# Famylia — Design Standard

Questa guida definisce come costruire nuove schermate e componenti in Famylia.
Il design system si basa su **shadcn_ui** (^0.27.0). Tutti i nuovi file devono rispettare questi standard.

---

## Setup obbligatorio

Ogni file Dart con UI deve importare shadcn_ui e ottenere il tema in `build()`:

```dart
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@override
Widget build(BuildContext context) {
  final shadTheme = ShadTheme.of(context); // ← sempre prima riga in build()
  // ...
}
```

---

## Scaffold

```dart
Scaffold(
  backgroundColor: shadTheme.colorScheme.background,
  appBar: AppBar(
    backgroundColor: shadTheme.colorScheme.background,
    surfaceTintColor: Colors.transparent,
    title: Text('Titolo schermata', style: shadTheme.textTheme.h4),
  ),
  body: ...,
)
```

---

## Colori

| Uso                     | Token shadcn                              |
|-------------------------|-------------------------------------------|
| Sfondo schermata        | `shadTheme.colorScheme.background`        |
| Testo principale        | `shadTheme.colorScheme.foreground`        |
| Testo secondario/muted  | `shadTheme.colorScheme.mutedForeground`   |
| Sfondo muted/card       | `shadTheme.colorScheme.muted`             |
| Colore primario         | `shadTheme.colorScheme.primary`           |
| Testo su primario       | `shadTheme.colorScheme.primaryForeground` |
| Bordi                   | `shadTheme.colorScheme.border`            |
| Errori/distruttivo      | `shadTheme.colorScheme.destructive`       |
| Evidenziazione          | `shadTheme.colorScheme.primary.withValues(alpha: 0.1)` |

**Non usare mai** `Theme.of(context)`, `colorScheme.error`, `colorScheme.surface`, `colorScheme.outline`.

---

## Tipografia

| Uso                   | Token shadcn                  |
|-----------------------|-------------------------------|
| Titolo pagina (H1)    | `shadTheme.textTheme.h1`      |
| Titolo sezione (H2)   | `shadTheme.textTheme.h2`      |
| Titolo card (H3)      | `shadTheme.textTheme.h3`      |
| Label/AppBar (H4)     | `shadTheme.textTheme.h4`      |
| Corpo testo           | `shadTheme.textTheme.p`       |
| Testo secondario      | `shadTheme.textTheme.muted`   |
| Etichette piccole     | `shadTheme.textTheme.small`   |

Per bold: `shadTheme.textTheme.p?.copyWith(fontWeight: FontWeight.bold)`

**Non usare** `Theme.of(context).textTheme.*`.

---

## Pulsanti

### Pulsante primario (azione principale)
```dart
ShadButton(
  onPressed: _loading ? null : _submit,
  width: double.infinity,
  child: _loading
      ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
      : const Text('Salva'),
)
```

### Pulsante secondario/outline
```dart
ShadButton.outline(
  onPressed: _action,
  width: double.infinity,
  child: const Text('Annulla'),
)
```

### Pulsante ghost (link, azioni minori)
```dart
ShadButton.ghost(
  onPressed: () => context.push(AppRoutes.somewhere),
  child: const Text('Vedi tutto'),
)
```

### Pulsante con icona
```dart
ShadButton(
  onPressed: _action,
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, size: 18),
      SizedBox(width: 8),
      Text('Aggiungi'),
    ],
  ),
)
```

### Pulsante icona solo
```dart
ShadButton(
  onPressed: _action,
  size: ShadButtonSize.icon,
  child: const Icon(Icons.add, size: 18),
)
```

### Pulsante distruttivo (elimina, esci)
```dart
ShadButton(
  onPressed: _deleteAction,
  backgroundColor: shadTheme.colorScheme.destructive,
  foregroundColor: Colors.white,
  child: const Text('Elimina'),
)
```

---

## Input

```dart
ShadInput(
  controller: _controller,
  placeholder: const Text('Testo segnaposto'),
  leading: Padding(
    padding: const EdgeInsets.only(left: 4),
    child: Icon(Icons.email_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
  ),
  onSubmitted: (_) => _submit(),
)
```

Varianti utili:
- `obscureText: true` — password
- `keyboardType: TextInputType.emailAddress` — email
- `textCapitalization: TextCapitalization.words` — nomi
- `maxLines: 3` — testo lungo

**Non usare** `TextField`, `TextFormField`, `Form` + `validator`. Usa validazione manuale con una variabile `String? _error`.

### Pattern validazione manuale
```dart
String? _error;

Future<void> _submit() async {
  if (_nameCtrl.text.trim().isEmpty) {
    setState(() => _error = 'Campo obbligatorio');
    return;
  }
  setState(() { _loading = true; _error = null; });
  // ...
}

// Nel build:
if (_error != null)
  Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Text(_error!, style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 14)),
  ),
```

---

## Card

```dart
ShadCard(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Titolo', style: shadTheme.textTheme.h4),
      Text('Sottotitolo', style: shadTheme.textTheme.muted),
    ],
  ),
)
```

Card con colore di sfondo:
```dart
ShadCard(
  backgroundColor: shadTheme.colorScheme.primary.withValues(alpha: 0.1),
  child: ...,
)
```

Card avviso/errore:
```dart
ShadCard(
  backgroundColor: shadTheme.colorScheme.destructive.withValues(alpha: 0.1),
  child: ...,
)
```

**Non usare** `Card(...)`.

---

## Badge / Chip informativo

```dart
ShadBadge.raw(
  variant: ShadBadgeVariant.secondary,
  child: const Text('In evidenza'),
)
```

---

## Dialog (Alert / Conferma)

I dialog usano `AlertDialog` di Material ma con bottoni shadcn:

```dart
final ok = await showDialog<bool>(
  context: context,
  builder: (ctx) => AlertDialog(
    title: const Text('Titolo'),
    content: const Text('Sei sicuro?'),
    actions: [
      ShadButton.ghost(
        onPressed: () => Navigator.pop(ctx, false),
        child: const Text('Annulla'),
      ),
      ShadButton(
        onPressed: () => Navigator.pop(ctx, true),
        child: const Text('Conferma'),
      ),
    ],
  ),
);
```

Dialog distruttivo:
```dart
actions: [
  ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
  ShadButton(
    backgroundColor: shadTheme.colorScheme.destructive,
    foregroundColor: Colors.white,
    onPressed: () => Navigator.pop(ctx, true),
    child: const Text('Elimina'),
  ),
],
```

Input dentro un dialog: usa `TextField` con `InputDecoration` (il tema Material del dialog gestisce lo stile).

---

## FloatingActionButton

FAB non ha equivalente shadcn. Usalo con i colori del tema:

```dart
FloatingActionButton(
  onPressed: _add,
  backgroundColor: shadTheme.colorScheme.primary,
  foregroundColor: shadTheme.colorScheme.primaryForeground,
  child: const Icon(Icons.add),
)
```

---

## Banner / Avviso inline

Per avvisi contestuali (es. offline, stato) usa un `Container` invece di `MaterialBanner`:

```dart
Container(
  width: double.infinity,
  color: shadTheme.colorScheme.destructive.withValues(alpha: 0.1),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  child: Row(
    children: [
      Icon(Icons.cloud_off, size: 18, color: shadTheme.colorScheme.destructive),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          'Offline — modifiche in coda',
          style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 13),
        ),
      ),
      ShadButton.ghost(
        onPressed: _retry,
        size: ShadButtonSize.sm,
        child: const Text('Riprova'),
      ),
    ],
  ),
)
```

---

## Widget Material accettati

I seguenti widget Material non hanno equivalente shadcn e rimangono invariati:

| Widget              | Motivo                          |
|---------------------|---------------------------------|
| `NavigationBar`     | Nessun equivalente shadcn       |
| `NavigationRail`    | Nessun equivalente shadcn       |
| `FloatingActionButton` | Nessun equivalente shadcn    |
| `SegmentedButton`   | Nessun equivalente shadcn       |
| `ActionChip` / `FilterChip` | Nessun equivalente shadcn |
| `CheckboxListTile`  | Nessun equivalente shadcn       |
| `SwitchListTile`    | Nessun equivalente shadcn       |
| `ListTile`          | Nessun equivalente shadcn       |
| `Dismissible`       | Comportamento specifico Flutter |
| `PopupMenuButton`   | Nessun equivalente shadcn       |
| `DropdownButtonFormField` | Usato solo nei dialog     |
| `TabBar` / `TabBarView` | Nessun equivalente shadcn   |
| `CircleAvatar`      | Nessun equivalente shadcn       |

Questi widget devono usare i colori di `ShadTheme` quando hanno proprietà di colore configurabili.

---

## Snackbar / Feedback

Usa sempre `ScaffoldMessenger` per i feedback testuali:

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Operazione completata')),
);
```

---

## Struttura file tipo

```dart
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
// altri import...

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Titolo', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(_error!, style: TextStyle(color: shadTheme.colorScheme.destructive)),
                ),
              // contenuto...
            ],
          ),
        ),
      ),
    );
  }
}
```
