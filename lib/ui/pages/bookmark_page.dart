import 'package:currency_exchange_app/data/localstorage/local_data_source.dart';
import 'package:flutter/cupertino.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({super.key});

  final local = LocalDataSource();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bookmark'),
    );
  }
}
