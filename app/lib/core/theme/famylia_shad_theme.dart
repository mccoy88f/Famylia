import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'famylia_accent_presets.dart';

/// Tema Shad base (zinc) + override accento famiglia senza animazione globale.
abstract final class FamyliaShadTheme {
  static final ShadThemeData lightBase = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: const ShadZincColorScheme.light(),
  );

  static final ShadThemeData darkBase = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: const ShadZincColorScheme.dark(),
  );
}

/// Applica il colore accento famiglia sopra il [ShadTheme] di [ShadApp].
class FamyliaAccentTheme extends StatelessWidget {
  const FamyliaAccentTheme({
    required this.accentHex,
    required this.child,
    super.key,
  });

  final String accentHex;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final parent = ShadTheme.of(context);
    final accent = FamyliaAccentPresets.colorFromHex(accentHex);
    final onAccent = accent.computeLuminance() > 0.5
        ? const Color(0xFF1A1D26)
        : Colors.white;
    final scheme = parent.brightness == Brightness.dark
        ? ShadZincColorScheme.dark(
            primary: accent,
            primaryForeground: onAccent,
          )
        : ShadZincColorScheme.light(
            primary: accent,
            primaryForeground: onAccent,
          );
    return ShadTheme(
      data: parent.copyWith(colorScheme: scheme),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
