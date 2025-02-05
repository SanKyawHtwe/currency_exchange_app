import 'package:currency_exchange_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static LocalDataSource localDataSource = LocalDataSource();
  static LocalDataSource get instance => localDataSource;
  late SharedPreferences _prefs;

  Future<void> initSharePf() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLoginStatus() async {
    await _prefs.setBool(isLoggedInKey, true);
  }

  Future<void> saveLogoutStatus() async {
    await _prefs.setBool(isLoggedInKey, false);
  }

  Future<bool> getLoginInfo() async {
    final isLoggedIn = _prefs.getBool(isLoggedInKey);
    return isLoggedIn ?? false;
  }
}
