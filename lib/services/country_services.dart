import 'package:dio/dio.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/utils/utils.dart';

class CountryServices {
  static Dio dio = Dio();

  static List<CountryModel> getCountry() {
    listCountries.sort((a, b) => a.country!.compareTo(b.country!));
    return listCountries
        .map((e) => CountryModel(
            code: e.code,
            country: e.country,
            hintText: e.hintText,
            flagUrl: baseUrlFlag(e.code!)))
        .toList();
  }
}
