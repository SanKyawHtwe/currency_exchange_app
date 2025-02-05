import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:hive/hive.dart';

class AuthService {
  Box<User>? _userBox;
  Future<Box<User>> _getUserBox() async {
    _userBox ??= await Hive.openBox<User>(usersBox);
    return _userBox!;
  }

  Future<void> saveUser(User user) async {
    final userBox = await _getUserBox();
    await userBox.put(currentUserKey, user);
    print('User saved: ${user.name}, ${user.email}');
  }

  Future<User?> getUser() async {
    final userBox = await _getUserBox();
    final user = userBox.get(currentUserKey);
    if (user != null) {
      print('User retrieved: ${user.name}, ${user.email}}');
    } else {
      print('No user found');
    }
    return user;
  }

  Future<void> logout() async {
    final userBox = await _getUserBox();
    await userBox.clear();
    print('User data cleared.');
  }
}
