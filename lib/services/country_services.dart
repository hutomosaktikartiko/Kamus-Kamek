import 'package:dio/dio.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/utils/utils.dart';

class CountryServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<List<CountryModel>>> getCountry() async {
    try {
      String url = baseUrlCountry;

      var response = await dio.get(url, queryParameters: {
        "limit": 1000
      });

      print("{ SUCCESS GET COUNTRY $response}");

      Map<String, dynamic> results = response.data['data'];

      return ApiReturnValue(
          value: results.keys
              .map((e) => CountryModel(
                  code: e.toLowerCase(),
                  country: results[e]['country'],
                  region: results[e]['region'],
                  flagUrl: baseUrlFlag(e.toLowerCase())))
              .toList());
    } on DioError catch (e) {
      print("{ ERROR GET COUNTRY $e}");
      return ApiReturnValue(
          message:
              e.response?.data['message'] ?? "Gagal mendapatkan list country");
    }
  }
}
