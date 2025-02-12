import 'package:currency_exchange_app/data/local/hive_local_data_source.dart';
import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/utils/string.dart';

class AuthService {
  HiveLocalDataSource hive = HiveLocalDataSource();
  Future<void> saveUser(User user) async {
    await hive.userBox?.put(currentUserKey, user);
    print('User saved: ${user.name}, ${user.email}');
  }

  Future<User?> getUser() async {
    final user = hive.userBox?.get(currentUserKey);
    if (user != null) {
      print('User retrieved: ${user.name}, ${user.email}}');
    } else {
      print('No user found');
    }
    return user;
  }

  Future<void> logout() async {
    await hive.userBox?.clear();
    print('User data cleared.');
  }
}
