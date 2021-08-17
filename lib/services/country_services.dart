import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountryServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<ApiReturnValue<List<CountryModel>>> getCountries() async {
    CollectionReference countriesReference = _firestore.collection("countries");
    try {
      QuerySnapshot snapshots = await countriesReference.get();

      print("{ RESPONSE GET COUNTRIES $snapshots }");

      List<QueryDocumentSnapshot> docs = snapshots.docs;

      return ApiReturnValue(
          value: docs.map((e) => CountryModel.fromJson(e)).toList());
    } catch (e) {
      return ApiReturnValue(message: "Gagal mendapatkan list countries",);
    }
  }
}