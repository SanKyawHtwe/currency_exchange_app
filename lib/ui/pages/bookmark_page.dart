import 'package:currency_exchange_app/data/local/auth_service.dart';
import 'package:currency_exchange_app/data/local/bookmark_service.dart';
import 'package:currency_exchange_app/data/local/local_data_source.dart';
import 'package:currency_exchange_app/data/models/bookmark_model.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({super.key});

  final local = LocalDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(child: BodyView()),
    );
  }
}

class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  final bookmarkService = BookmarkService();
  final auth = AuthService();
  List<Bookmark> bookmarks = [];

  Future<void> getBookmarks() async {
    final currentUser = await auth.getUser();
    final response =
        await bookmarkService.getBookmark(currentUser?.name ?? 'Guest user');
    setState(() {
      bookmarks = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return bookmarks.isEmpty
        ? Center(
            child: Text(noBookmarkText),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                return ListTile(
                  leading:
                      Text('${bookmark.fromCurrency} ${bookmark.inputValue}'),
                  title: Text('='),
                  trailing:
                      Text('${bookmark.toCurrency} ${bookmark.outputValue}'),
                );
              },
            ),
          );
  }
}
