import 'dart:convert';

import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static LocalDataSource localDataSource = LocalDataSource();
  static LocalDataSource get instance => localDataSource;
  late SharedPreferences _prefs;
  Future<SharedPreferences> initSharePf() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  Future<void> saveLoginStatus() async {
    await _prefs.setBool(sharedPrefsKey, true);
  }

  Future<void> saveLogoutStatus() async {
    // final SharedPreferences prefs = await _prefs;
    await _prefs.setBool(sharedPrefsKey, false);
  }

  Future<bool> getLoginInfo() async {
    // final SharedPreferences prefs = await _prefs;
    final isLogggedIn = _prefs.getBool(sharedPrefsKey);
    return isLogggedIn ?? false;
  }

  Future<void> saveUser(User user) async {
    //  final SharedPreferences prefs = await _prefs;
    await _prefs.setString('user_info', user.toJson());
  }

  Future<User?> getUser() async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = _prefs.getString('user_info');
    if (userJson == null) return null;

    final Map<String, dynamic> userMap = json.decode(userJson);

    return User.fromJson(userMap);
  }
}
