import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyModel {
  final ValueNotifier<Currencies> fromCurrency =
      ValueNotifier<Currencies>(Currencies.usd);
  final ValueNotifier<Currencies> toCurrency =
      ValueNotifier<Currencies>(Currencies.mmk);
  final ValueNotifier<Currencies> tmp =
      ValueNotifier<Currencies>(Currencies.php);
  final ValueNotifier<String> result = ValueNotifier<String>("");

  final fiveDecimalFormat = NumberFormat.currency(symbol: '', decimalDigits: 5);
  final currencyFormat = NumberFormat.currency(symbol: '');
  final sameFormat = NumberFormat.currency(symbol: '', decimalDigits: 0);

  void swapCurrencies() {
    tmp.value = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = tmp.value;
  }

  final Map<Currencies, Map<Currencies, double>> exchangeRates = {
    Currencies.usd: {
      Currencies.usd: 1.0,
      Currencies.mmk: 2078.61,
      Currencies.php: 58.5142,
      Currencies.thb: 34.558,
    },
    Currencies.mmk: {
      Currencies.usd: 0.00047,
      Currencies.mmk: 1.0,
      Currencies.php: 0.02761,
      Currencies.thb: 0.01631,
    },
    Currencies.php: {
      Currencies.usd: 0.01707,
      Currencies.mmk: 36.2169,
      Currencies.php: 1.0,
      Currencies.thb: 0.59125,
    },
    Currencies.thb: {
      Currencies.usd: 0.02892,
      Currencies.mmk: 60.1035,
      Currencies.php: 1.69195,
      Currencies.thb: 1.0,
    },
  };

  void calculateResult({
    required String fromValue,
    required Currencies fromCurrency,
    required Currencies toCurrency,
  }) {
    if (fromValue.isEmpty) {
      result.value = '';
      return;
    }

    try {
      double amount = double.parse(fromValue);
      double exchangeRate = exchangeRates[fromCurrency]?[toCurrency] ?? 1.0;
      double exchangedAmount = amount * exchangeRate;

      if (toCurrency == fromCurrency) {
        result.value = sameFormat.format(exchangedAmount);
      } else if (toCurrency == Currencies.usd) {
        result.value = fiveDecimalFormat.format(exchangedAmount);
      } else if (fromCurrency == Currencies.mmk) {
        result.value = fiveDecimalFormat.format(exchangedAmount);
      } else {
        result.value = currencyFormat.format(exchangedAmount);
      }
    } catch (e) {
      result.value = '';
    }
  }
}

enum Currencies {
  usd('USD', Icons.flag),
  thb('THB', Icons.flag_circle_outlined),
  php('PHP', Icons.flag_circle_rounded),
  mmk('MMK', Icons.flag_circle);

  const Currencies(this.label, this.icon);

  final String label;
  final IconData icon;
}
