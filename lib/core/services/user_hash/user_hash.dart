import 'package:shared_preferences/shared_preferences.dart';

class UserHash {
  static Future<void> saveUserHash(String userHash) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userHash', userHash);
  }

  static Future<String?> getUserHash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userHash');
  }
}
