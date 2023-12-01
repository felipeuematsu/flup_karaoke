import 'dart:ui';

extension LocaleExtension on Locale {
  /// Returns the language code for this locale.
  String get languageCode => toString().split('_')[0];

  /// Returns the country code for this locale.
  String get countryCode => toString().split('_')[1];

  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      'countryCode': countryCode,
    };
  }
}

Locale localeFromJson(Map<String, dynamic> json) {
  final languageCode = json['languageCode'] as String;
  final countryCode = json['countryCode'] as String;
  return Locale(languageCode, countryCode);
}
