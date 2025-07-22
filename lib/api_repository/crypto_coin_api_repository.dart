import 'package:dio/dio.dart';
import 'package:simple_application_for_review/constants.dart';
import 'package:simple_application_for_review/model/crypto_coin_model.dart';

abstract class CryptoCoinApiRepository {
  Future<List<CryptoCoinModel>> loadCrytoCoins({
    required int offset,
    required int limit,
  });
}

class CryptoCoinApiRepositoryImpl implements CryptoCoinApiRepository {
  final dio = Dio();

  @override
  Future<List<CryptoCoinModel>> loadCrytoCoins({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.path}',
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          'limit': limit,
          'offset': offset,
        },
      );

      final coinsList = response.data['data'] as List;

      return coinsList.map((e) => CryptoCoinModel.fromJson(e)).toList();
    } catch (error) {
      print(error.toString());
    }

    return [];
  }
}
