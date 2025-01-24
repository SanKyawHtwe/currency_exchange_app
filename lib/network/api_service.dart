import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/network/api_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3)));

  Future<CurrencyModel> getLatestExchangeRate() async {
    try {
      final response = await _dio.get('/v3/latest', queryParameters: {
        'apikey': kApiKey,
      });

      var responseModel = CurrencyModel.fromJson(response.data);

      return responseModel;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        // Handle connection timeout
        throw 'Connection timeout. Please try again later.';
      } else {
        // Handle other errors
        throw 'Error fetching latest exchange rate: ${e.message}';
      }
    } catch (e) {
      print('Error fetching latest exchange rate: $e');
      throw 'An unexpected error occurred. Please try again later.';
    }
  }
}
