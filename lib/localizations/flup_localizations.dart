import 'package:flup_karaoke/app_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FlupLocalizations {
  FlupLocalizations(this.locale);

  final Locale locale;

  static FlupLocalizations? of(BuildContext context) {
    return Localizations.of<FlupLocalizations>(context, FlupLocalizations);
  }
}

class FlupLocalizationsDelegate extends LocalizationsDelegate<FlupLocalizations> {
  const FlupLocalizationsDelegate();
  static const translations = AppTranslations();

  @override
  bool isSupported(Locale locale) {
    return translations.keys.containsKey(locale) == true;
  }

  @override
  Future<FlupLocalizations> load(Locale locale) {
    return SynchronousFuture<FlupLocalizations>(FlupLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<FlupLocalizations> old) {
    return false;
  }
}
