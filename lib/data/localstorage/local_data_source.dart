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

  Future<void> saveData<T>(String key, T value) async {
    try {
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
      } else {
        await _prefs.setString(key, json.encode(value));
      }
    } catch (e) {
      print("Error saving data for key '$key': $e");
    }
  }

  Future<T?> getData<T>(String key) async {
    try {
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
      } else {
        final String? jsonString = _prefs.getString(key);
        if (jsonString != null) {
          return _decodeCustomObject<T>(jsonString);
        }
      }
    } catch (e) {
      print("Error retrieving data for key '$key': $e");
    }
    return null;
  }

  T? _decodeCustomObject<T>(String jsonString) {
    if (T == User) {
      final Map<String, dynamic> map = json.decode(jsonString);
      return User.fromJson(map) as T?;
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
    final bool? isLoggedIn = await getData<bool>(isLoggedInKey);
    return isLoggedIn ?? false;
  }

  Future<void> saveUser(User user) async {
    await saveData(kUserInfoKey, user);
  }

  Future<User?> getUser() async {
    final user = await getData<User>(kUserInfoKey);
    return user;
  }
}
