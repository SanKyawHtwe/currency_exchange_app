import 'package:currency_exchange_app/data/local/hive_local_data_source.dart';
import 'package:currency_exchange_app/data/models/bookmark_model.dart';

class BookmarkService {
  HiveLocalDataSource hive = HiveLocalDataSource();

  Future<void> saveBookmark(String userName, Bookmark bookmark) async {
    final box = hive.bookmarkBox;
    // Retrieve existing data or initialize an empty list
    List<Map<String, dynamic>> bookmarks =
        (box?.get(userName) as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    // Add new bookmark as a map
    bookmarks.add(bookmark.toJson());
    await box?.put(userName, bookmarks);
    print("Bookmarks saved: $bookmark");
  }

  Future<List<Bookmark>> getBookmark(String userName) async {
    final box = hive.bookmarkBox;
    var bookmarkData = box?.get(userName);
    List<Bookmark> bookmarks = [];
    List<dynamic> data = (bookmarkData as List<dynamic>);
    for (var v in data) {
      Bookmark bookmark = Bookmark.fromMap(v);
      bookmarks.add(bookmark);
    }
    return bookmarks;
  }
}
