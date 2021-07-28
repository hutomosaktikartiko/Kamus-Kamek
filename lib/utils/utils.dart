const String googleApiKey = "AIzaSyD8jPqBBAGIMi_0rjnXtb_F0feyy50rAPk";
const String baseUrlGoogleApi =
    "https://translation.googleapis.com/language/translate/v2";
const String baseUrlCountry = "https://api.first.org/data/v1/countries";

String baseUrlFlag(String countryCode) =>
    "https://www.countryflags.io/$countryCode/flat/64.png";
