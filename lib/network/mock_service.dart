import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:intl/intl.dart';

class MockService {
  Future<CurrencyModel> getLatestExchangeRate() async {
    await Future.delayed(Duration(seconds: 2));
    final DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM d, y – h:mm a').format(now);
    return CurrencyModel(
      meta: Meta(lastUpdatedAt: formattedDate),
      data: Data(
        currencies: {
          Code.USD: Currencies(code: Code.USD, value: 1.0),
          Code.THB: Currencies(code: Code.THB, value: 33.9808063958),
          Code.MMK: Currencies(code: Code.MMK, value: 2098.3990133762),
          Code.PHP: Currencies(code: Code.PHP, value: 58.639269644),
          Code.KHR: Currencies(code: Code.KHR, value: 4017.7942960831),
          Code.VND: Currencies(code: Code.VND, value: 25078.609159418),
          Code.SGD: Currencies(code: Code.SGD, value: 1.3555201464),
          Code.LAK: Currencies(code: Code.LAK, value: 21692.493544719),
        },
      ),
    );
  }
}
