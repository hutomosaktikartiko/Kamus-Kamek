import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences shared;

  Preferences(this.shared);

  // Save Data
  set isNewUser(bool? value) => shared.setBool("is_new_user", value ?? false);
  set defaultLanguage(String? value) => shared.setString("code_country", value ?? "");

  // Get Stored Data
  bool? get isNewUser => shared.getBool("is_new_user");
  String get defaultLanguage => shared.getString("code_country") ?? "";

  static Future<Preferences> instance() =>
      SharedPreferences.getInstance().then((value) => Preferences(value));
}