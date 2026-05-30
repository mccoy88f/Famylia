import 'package:flutter/material.dart';

/// Preset colore accento famiglia — palette pulita e accessibile.
abstract final class FamyliaAccentPresets {
  static const defaultHex = '#5B8DEF';

  static const presets = <AccentPreset>[
    AccentPreset('#5B8DEF', 'Blu'),
    AccentPreset('#6B9E78', 'Verde'),
    AccentPreset('#4DB6AC', 'Teal'),
    AccentPreset('#9B7BB8', 'Viola'),
    AccentPreset('#7EB8DA', 'Cielo'),
    AccentPreset('#E07A5F', 'Corallo'),
    AccentPreset('#D4A574', 'Ambra'),
    AccentPreset('#E87A3B', 'Arancio'),
  ];

  static Color colorFromHex(String? hex) {
    final value = _parseHex(hex ?? defaultHex);
    return Color(0xFF000000 | value);
  }

  static int _parseHex(String hex) {
    var h = hex.trim().toUpperCase();
    if (h.startsWith('#')) h = h.substring(1);
    if (h.length != 6) return 0x5B8DEF;
    return int.parse(h, radix: 16);
  }
}

class AccentPreset {
  const AccentPreset(this.hex, this.label);
  final String hex;
  final String label;

  Color get color => FamyliaAccentPresets.colorFromHex(hex);
}
