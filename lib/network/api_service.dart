import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/network/api_constants.dart';
import 'package:currency_exchange_app/utils/result.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60)));

  Future<Result<CurrencyModel>> getLatestExchangeRate() async {
    try {
      final response = await _dio.get('/v3/latest', queryParameters: {
        'apikey': kApiKey,
      });

      var responseModel = CurrencyModel.fromJson(response.data);

      return Result.success(responseModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Result.error('Connection timeout. Please try again.');
      } else {
        return Result.error("Something went wrong. Please try again.");
      }
    } catch (e) {
      return Result.error("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> fetchExchangeRates({
    required String startDate,
    required String endDate,
    required String baseCurrency,
  }) async {
    List<String> symbols = Code.values.map((code) {
      return code.value;
    }).toList();
    try {
      String symbolsParam = symbols.join(',');
      String url =
          '$kHistoricalUrl/$startDate..$endDate?base=$baseCurrency&symbols=$symbolsParam';

      Response response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception("Connection error");
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }
}
