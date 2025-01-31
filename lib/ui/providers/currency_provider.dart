import 'package:currency_exchange_app/data/models/currency_model.dart';
import 'package:currency_exchange_app/data/network/api_service.dart';
import 'package:currency_exchange_app/utils/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyProvider extends ChangeNotifier {
  final _apiService = ApiService();
  final fiveDecimalFormat = NumberFormat.currency(symbol: '', decimalDigits: 5);
  final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);
  final sameFormat = NumberFormat.currency(symbol: '', decimalDigits: 0);
  final ValueNotifier<Code> fromCurrency = ValueNotifier<Code>(Code.USD);
  final ValueNotifier<Code> toCurrency = ValueNotifier<Code>(Code.MMK);
  final ValueNotifier<String> result = ValueNotifier<String>("");

  bool isLoading = false;
  CurrencyModel? _currencyData;
  CurrencyModel? get currencyData => _currencyData;
  String? errorMessage;
  String? get errorMsg => errorMessage;

  Future<Result<CurrencyModel>> getExchangeRate() async {
    isLoading = true;
    result.value = '';
    errorMessage = null;
    notifyListeners();

    final response = await _apiService.getLatestExchangeRate();

    {
      if (response.isSuccess) {
        _currencyData = response.data!;
      } else {
        errorMessage = response.error!;
      }
    }

    isLoading = false;
    notifyListeners();
    return response;
  }

  void swapCurrencies() {
    final tmp = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = tmp;
  }

  void calculateResult({
    required String inputAmount,
    required Code fromCurrency,
    required Code toCurrency,
  }) {
    double exchangedAmount = 0.0;

    if (inputAmount.trim().isEmpty) {
      result.value = '';
      return;
    }

    try {
      double? amount = double.tryParse(inputAmount);
      if (amount == null) {
        result.value = '';
        return;
      }
      final rates = currencyData?.data?.currencies as Map<Code, dynamic>;

      final fromRate = rates[fromCurrency].value;
      final toRate = rates[toCurrency].value;

      if (fromRate == null || toRate == null) {
        throw Exception('Invalid currency type');
      }

      if (fromCurrency == Code.USD) {
        exchangedAmount = amount * toRate;
      } else if (toCurrency == Code.USD) {
        exchangedAmount = amount / fromRate;
      } else {
        exchangedAmount = amount * (toRate / fromRate);
      }

      if (fromCurrency == toCurrency) {
        result.value = sameFormat.format(exchangedAmount);
      } else if (toCurrency == Code.USD) {
        result.value = fiveDecimalFormat.format(exchangedAmount);
      } else if (fromCurrency == Code.USD) {
        result.value = currencyFormat.format(exchangedAmount);
      } else {
        result.value = fiveDecimalFormat.format(exchangedAmount);
      }
    } catch (e) {
      result.value = '';
    }
  }
}
