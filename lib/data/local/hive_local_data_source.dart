import 'package:currency_exchange_app/data/models/bookmark_model.dart';
import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// class HiveLocalDataSource {
//   static final HiveLocalDataSource _instance = HiveLocalDataSource._internal();

//   factory HiveLocalDataSource() {
//     return _instance;
//   }

//   HiveLocalDataSource._internal();

//   static HiveLocalDataSource get instance => _instance;

//   Box<User>? userBox;
//   Box<List<Bookmark>>? bookmarkBox;

//   Future<void> initHive() async {
//     try {
//       final appDocumentDirectory = await getApplicationDocumentsDirectory();
//       Hive.init(appDocumentDirectory.path);

//       Hive.registerAdapter(UserAdapter());

//       Hive.registerAdapter(BookmarkAdapter());

//       userBox = await Hive.openBox<User>(usersBoxKey);
//       bookmarkBox = await Hive.openBox<List<Bookmark>>(bookmarkBoxKey);

//       print('Hive initialized and boxes opened successfully');
//     } catch (e) {
//       print('Error initializing Hive or opening boxes: $e');
//     }
//   }

//   Future<Box<User>> getUserBox() async {
//     if (userBox == null) {
//       await initHive();
//     }
//     return userBox!;
//   }

//   Future<Box<List<Bookmark>>> getBookmarkBox() async {
//     if (bookmarkBox == null) {
//       await initHive();
//     }
//     return bookmarkBox!;
//   }
// }

class HiveLocalDataSource {
  static final HiveLocalDataSource _instance = HiveLocalDataSource._internal();

  factory HiveLocalDataSource() {
    return _instance;
  }

  HiveLocalDataSource._internal();
  static HiveLocalDataSource get instance => _instance;

  Box<User>? userBox;
  Box<dynamic>? bookmarkBox;

  Future<void> initHive() async {
    try {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);

      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(BookmarkAdapter());

      userBox = await Hive.openBox<User>(usersBoxKey);
      bookmarkBox = await Hive.openBox<dynamic>('bookmarkBox');

      print('Hive initialized and boxes opened successfully');
    } catch (e) {
      print('Error initializing Hive or opening boxes: $e');
    }
  }

  Future<Box<User>> getUserBox() async {
    if (userBox == null) {
      await initHive();
    }
    return userBox!;
  }

  Future<Box<dynamic>> getBookmarkBox() async {
    if (bookmarkBox == null) {
      await initHive();
    }
    return bookmarkBox!;
  }
}
