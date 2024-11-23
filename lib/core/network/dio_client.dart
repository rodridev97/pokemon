import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'),
  );

  static Dio get dio => _dio;
}
