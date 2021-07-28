class TranslationModel {
  String? translatedText, dectectedSourceLanguage;

  TranslationModel({this.dectectedSourceLanguage, this.translatedText});

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
          translatedText:
              (json['translatedText'] == null) ? null : json['translatedText'],
          dectectedSourceLanguage: (json['detectedSourceLanguage'] == null)
              ? null
              : json['detectedSourceLanguage']);
}