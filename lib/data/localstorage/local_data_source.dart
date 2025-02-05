import 'dart:convert';
import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static LocalDataSource localDataSource = LocalDataSource();
  static LocalDataSource get instance => localDataSource;
  late SharedPreferences _prefs;

  Future<void> initSharePf() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData<T>(String key, T value) async {
    await initSharePf();
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else if (value is User) {
      await _prefs.setString(key, json.encode(value));
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<T?> getData<T>(String key) async {
    await initSharePf();
    if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T?;
    } else if (T == User) {
      final String? userJson = _prefs.getString(key);
      if (userJson != null) {
        final Map<String, dynamic> userMap = json.decode(userJson);
        return User.fromJson(userMap) as T?;
      }
    }
    return null;
  }

  Future<void> saveLoginStatus() async {
    await saveData(isLoggedInKey, true);
  }

  Future<void> saveLogoutStatus() async {
    await saveData(isLoggedInKey, false);
  }

  Future<bool> getLoginInfo() async {
    return await getData<bool>(isLoggedInKey) ?? false;
  }

  Future<void> saveUser(User user) async {
    await saveData(kUserInfoKey, user.toJson());
  }

  Future<User?> getUser() async {
    final user = await getData<User>(kUserInfoKey);
    return user;
  }
}
