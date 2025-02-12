import 'dart:convert';

import 'package:hive/hive.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 2)
class Bookmark {
  @HiveField(0)
  final String fromCurrency;

  @HiveField(1)
  final String toCurrency;

  @HiveField(2)
  final String inputValue;

  @HiveField(3)
  final String outputValue;

  Bookmark({
    required this.fromCurrency,
    required this.toCurrency,
    required this.inputValue,
    required this.outputValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'inputValue': inputValue,
      'outputValue': outputValue
    };
  }

  factory Bookmark.fromMap(Map<dynamic, dynamic> map) {
    return Bookmark(
      fromCurrency: map['fromCurrency'],
      toCurrency: map['toCurrency'],
      inputValue: map['inputValue'],
      outputValue: map['outputValue'],
    );
  }

  String toString() => json.encode(toJson());
  factory Bookmark.fromJson(String source) =>
      Bookmark.fromMap(json.decode(source));
}
