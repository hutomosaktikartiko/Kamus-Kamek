import 'package:dio/dio.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/utils/utils.dart';

class CountryServices {
  static Dio dio = Dio();

  static ApiReturnValue<List<CountryModel>> getCountry() {
    try {
      return ApiReturnValue(
        value: listCountries.map((e) => CountryModel(
          code: e.code,
          country: e.country,
          hintText: e.hintText,
          flagUrl: baseUrlFlag(e.code!)
        )).toList()
      );
    } on DioError catch (e) {
      print("{ ERROR GET COUNTRY $e}");
      return ApiReturnValue(
          message:
              e.response?.data['message'] ?? "Gagal mendapatkan list country");
    }
  }
}
