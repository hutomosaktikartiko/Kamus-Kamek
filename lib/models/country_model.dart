import 'package:kamus_kamek/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  String? code, country, flagUrl, hintText;

  CountryModel({this.code, this.flagUrl, this.country, this.hintText});

  factory CountryModel.fromJson(QueryDocumentSnapshot document) => CountryModel(
    code: document['code'],
    country: document['country'],
    flagUrl: baseUrlFlag(document['code']),
    hintText: document['hint_text']
  );
}