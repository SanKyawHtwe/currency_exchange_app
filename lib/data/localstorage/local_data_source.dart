import 'package:currency_exchange_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(sharedPrefsKey, true);
  }

  Future<void> saveLogoutStatus() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(sharedPrefsKey, false);
  }

  Future<bool> getLoginInfo() async {
    final SharedPreferences prefs = await _prefs;
    final isLogggedIn = prefs.getBool(sharedPrefsKey);
    return isLogggedIn ?? false;
  }
}
