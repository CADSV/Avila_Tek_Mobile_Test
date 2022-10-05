// ignore_for_file: unrelated_type_equality_checks
// Flutter imports:
import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:avila_tek_test/infraestructure/core/constants/repository_constants.dart';
import 'package:avila_tek_test/infraestructure/core/flavor_manager.dart';


enum RepositoryManagerError {error}

class RepositoryManager {
  Future<BaseOptions> _dioOptions(
      String endpoint, int customHeader, String? clientCode) async {
    var repositoryHeader = <String, dynamic>{};

    var options = BaseOptions(
        baseUrl: FlavorManager.baseURL(),
        connectTimeout: const Duration(seconds: 30).inMilliseconds,
        receiveTimeout: const Duration(seconds: 30).inMilliseconds,
        responseType: ResponseType.plain,
        headers: repositoryHeader,
        contentType: 'application/json');

    return options;
  }

  void _validateCertificate(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<String?> request({required int operation, required String endpoint, Map<String, dynamic>? body, int customHeader = -1, String? clientCode}) async {
    var setDioOptions = await _dioOptions(endpoint, customHeader, clientCode);

    endpoint = FlavorManager.baseURL() + endpoint;

    var dio = Dio(setDioOptions);

    _validateCertificate(dio);

    Response? response;

    try {
      if (operation == RepositoryConstant.operationGet.key) {
        response = await dio.get(endpoint);
      } else if (operation == RepositoryConstant.operationPost.key) {
        response = await dio.post(endpoint, data: body);
      } else if (operation == RepositoryConstant.operationPut.key) {
        if (body != null) {
          response = await dio.put(endpoint, data: body);
        } else {
          response = await dio.put(endpoint);
        }
      } else if (operation == RepositoryConstant.operationDelete.key) {
        if (body != null) {
          response = await dio.delete(endpoint, data: body);
        } else {
          response = await dio.delete(endpoint);
        }
      }

      dio.close();

      return response?.data;
    } on DioError {

      throw RepositoryManagerError.error;

    }

  }

}
