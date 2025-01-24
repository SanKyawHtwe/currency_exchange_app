class CurrencyModel {
  final Meta? meta;
  final Data? data;
  CurrencyModel({this.meta, this.data});
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    const List<String> specificCurrencies = [
      'USD',
      'THB',
      'MMK',
      'PHP',
      'KHR',
      'VND',
      'SGD',
      'LAK',
    ];
    final filteredData = Map.fromEntries(
      (json['data'] as Map<String, dynamic>)
          .entries
          .where((entry) => specificCurrencies.contains(entry.key))
          .map(
              (entry) => MapEntry(entry.key, Currencies.fromJson(entry.value))),
    );
    return CurrencyModel(
      meta: Meta.fromJson(json['meta']),
      data: filteredData.isNotEmpty ? Data.fromJson(filteredData) : null,
    );
  }
}

class Meta {
  String? lastUpdatedAt;
  Meta({this.lastUpdatedAt});
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(lastUpdatedAt: json["last_updated_at"]);
  }
}

class Data {
  Map<Code, dynamic>? currencies;

  Data({this.currencies});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currencies: Map.fromEntries(
        json.entries
            .where((entry) =>
                Code.values.any((e) => e.value == entry.key) &&
                entry.value is Map<String, dynamic>)
            .map((entry) => MapEntry(
                  Code.values.firstWhere((e) => e.value == entry.key),
                  Currencies.fromJson(entry.value as Map<String, dynamic>),
                )),
      ),
    );
  }
}

class Currencies {
  Code? code;
  double? value;
  Currencies({this.code, this.value});
  factory Currencies.fromJson(Map<String, dynamic> json) {
    return Currencies(
        code: Code.values.firstWhere((e) => e.value == json["code"]),
        value: (json["value"] as num).toDouble());
  }
}

enum Code {
  USD('USD'),
  THB('THB'),
  MMK('MMK'),
  PHP('PHP'),
  KHR('KHR'),
  VND('VND'),
  SGD('SGD'),
  LAK('LAK');

  /// The string representation of the currency code.
  const Code(this.value);

  final String value;
}
