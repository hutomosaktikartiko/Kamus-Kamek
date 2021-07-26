import 'package:dio/dio.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/translation_model.dart';
import 'package:kamus_kamek/utils/utils.dart';

class TranslationServices {
  static Dio dio = Dio();

  static Future<ApiReturnValue<TranslationModel>> translateText({required String text, required String target}) async {
    try {
      FormData formData = FormData.fromMap({
        "key": googleApiKey,
        "q": text,
        "target": "id"
      });

      var response = await dio.post(baseUrlGoogleApi, data: formData);

      print("{ RESPONSE --> $response }");

      var result = response.data['data']['translations'][0];

      return ApiReturnValue(value: TranslationModel.fromJson(result));
    } on DioError catch (e) {
      print("{ ERROR TRANLATED TEXT --> $e}");
      return ApiReturnValue(message: e.response?.data['error']['messages']);
    }
  }
}