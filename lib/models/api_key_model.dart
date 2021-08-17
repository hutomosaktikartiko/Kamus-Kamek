import 'package:cloud_firestore/cloud_firestore.dart';

class APIKeyModel {
  String? name, key;

  APIKeyModel({this.name, this.key});

  factory APIKeyModel.fromJson(QueryDocumentSnapshot document) => APIKeyModel(
    name: document['name'],
    key: document['key']
  );
}