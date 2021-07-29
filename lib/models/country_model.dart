class CountryModel {
  String? code, country, flagUrl, hintText;

  CountryModel({this.code, this.flagUrl, this.country, this.hintText});
}

List<CountryModel> listCountries = [
  CountryModel(country: "Amharic", code: "am", hintText: "ጽሑፍ ያስገቡ"),
  CountryModel(country: "Arabic", code: "ar", hintText: "أدخل النص"),
  CountryModel(country: "Basque", code: "eu", hintText: "Idatzi testua"),
  CountryModel(country: "Bengali", code: "bn", hintText: "লেখা অন্তর্ভুক্ত করুন"),
  CountryModel(country: "Portuguese (Brazil)", code: "pt-BR", hintText: "Digite o texto"),
  CountryModel(country: "Bulgarian", code: "bg", hintText: "Въведете текст"),
  CountryModel(country: "Catalan", code: "ca", hintText: "Introduïu text"),
  CountryModel(country: "Croatian", code: "hr", hintText: "Unesite tekst"),
  CountryModel(country: "Czech", code: "cs", hintText: "Zadejte text"),
  CountryModel(country: "Danish", code: "da", hintText: "Indtast tekst"),
  CountryModel(country: "Dutch", code: "nl", hintText: "Tekst invoeren"),
  CountryModel(country: "English (US)", code: "en", hintText: "Enter text"),
  CountryModel(country: "Estonian", code: "et", hintText: "Sisestage tekst"),
  CountryModel(country: "Filipino", code: "fil", hintText: "Ipasok ang teksto"),
  CountryModel(country: "Finnish", code: "fi", hintText: "Kirjoita teksti"),
  CountryModel(country: "French", code: "fr", hintText: "Entrez du texte"),
  CountryModel(country: "German", code: "de", hintText: "Text eingeben"),
  CountryModel(country: "Greek", code: "el", hintText: "Εισαγάγετε κείμενο"),
  CountryModel(country: "Gujarati", code: "gu", hintText: "ટેક્સ્ટ દાખલ કરો"),
  CountryModel(country: "Hebrew", code: "iw", hintText: "הזן טקסט"),
  CountryModel(country: "Hindi", code: "hi", hintText: "लिखना प्रारम्भ करें"),
  CountryModel(country: "Hungarian", code: "hu", hintText: "Írjon be szöveget"),
  CountryModel(country: "Icelandic", code: "is", hintText: "Sláðu inn texta"),
  CountryModel(country: "Indonesian", code: "id", hintText: "Masukkan teks"),
];
