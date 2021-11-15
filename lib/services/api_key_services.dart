import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kamus_kamek/models/api_key_model.dart';
import 'package:kamus_kamek/models/api_return_value.dart';

class APIKeyServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<ApiReturnValue<List<APIKeyModel>>> getAPIKeys() async {
    CollectionReference countriesReference = _firestore.collection("api_key");
    try {
      QuerySnapshot snapshots = await countriesReference.get();

      log("{ RESPONSE GET APIKEY ${snapshots.docs[0].data()} }");

      List<QueryDocumentSnapshot> docs = snapshots.docs;

      return ApiReturnValue(
          value: docs.map((e) => APIKeyModel.fromJson(e)).toList());
    } catch (e) {
      return ApiReturnValue(message: "Gagal mendapatkan API Key",);
    }
  }
}