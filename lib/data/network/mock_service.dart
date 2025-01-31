import 'package:currency_exchange_app/data/models/currency_model.dart';
import 'package:currency_exchange_app/data/network/api_constants.dart';
import 'package:currency_exchange_app/utils/result.dart';
import 'package:dio/dio.dart';

class MockService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60)));
  Future<Result<CurrencyModel>> getLatestExchangeRate() async {
    await Future.delayed(Duration(milliseconds: 500));
    final DateTime now = DateTime.now();
    return Result.success(CurrencyModel(
      meta: Meta(lastUpdatedAt: now.toString()),
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
    ));
  }

  Future<Map<String, dynamic>> fetchExchangeRates({
    required String startDate,
    required String endDate,
    String baseCurrency = 'USD',
    List<String> symbols = const [
      'THB',
      'MMK',
      'PHP',
      'KHR',
      'VND',
      'SGD',
      'LAK'
    ],
  }) async {
    try {
      String symbolsParam = symbols.join(',');
      String url =
          '$kHistoricalUrl/$startDate..$endDate?base=$baseCurrency&symbols=$symbolsParam';

      Response response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }
}
