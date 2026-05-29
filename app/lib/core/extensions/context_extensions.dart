import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../session/family_context.dart';

extension FamyliaContext on BuildContext {
  int? get activeFamilyId => read<FamilyContext>().activeFamilyId;

  String? get activeFamilyName => read<FamilyContext>().activeFamilyName;
}
