import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences shared;

  Preferences(this.shared);

  // Save Data
  set isNewUser(bool? value) => shared.setBool("is_new_user", value!);

  // Get Stored Data
  bool? get isNewUser => shared.getBool("is_new_user");

  static Future<Preferences> instance() =>
      SharedPreferences.getInstance().then((value) => Preferences(value));
}