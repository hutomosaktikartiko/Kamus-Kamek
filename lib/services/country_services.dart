import 'package:dio/dio.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/utils/utils.dart';

class CountryServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<List<CountryModel>>> getLanguages() async {
    try {
      String url = baseAwsApiUrl + "languages";

      var response = await dio.get(url);

      print("{ GET LANGUAGES RESPONSE $response}");

      List results = response.data["results"];

      return ApiReturnValue(
        value: results.map((e) => CountryModel.fromJson(e)).toList()
      );
    } on DioError catch (e) {
      print("{ ERROR GET LANGUAGES ${e.response}}");
      return ApiReturnValue(message: e.response?.data["message"]);
    }
  }
}
