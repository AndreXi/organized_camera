import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localization {
  final BuildContext context;
  late AppLocalizations? _translations;

  Localization(this.context) {
    _translations = AppLocalizations.of(context);
  }

  AppLocalizations? get translations => _translations;
}
