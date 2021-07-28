class CountryModel {
  String? code, country, region, flagUrl;

  CountryModel({this.code, this.flagUrl, this.country, this.region});

  // factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
  //   code: json.keys
  // );
}