import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServiceBase {
  String baseUrl = "http://10.0.0.103:5000/api";
  final _timeout = const Duration(seconds: 30);

  Future<bool> ping() async {
    try {
      var newHeader = await _montarHeader(false);
      final response = await http
          .get(Uri.parse('$baseUrl/ping'), headers: newHeader)
          .timeout(_timeout);
      garantirSucesso(response);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> body,
      {bool autoriza = false}) async {
    try {
      var headers = await _montarHeader(autoriza);

      var response = await http.post(Uri.parse('$baseUrl$endpoint'),
          body: jsonEncode(body), headers: headers);
      garantirSucesso(response);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Map<String, String>> _montarHeader(bool autoriza) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    if (autoriza) {
      var token = await StorageService.getToken(true);
      if (token == null) {
        throw Exception("Not authorized");
      }
      headers.addAll({'Authorization': "Bearer $token"});
    }

    return headers;
  }

  Future<Response> put(String endpoint, String body,
      {bool autoriza = false, Map<String, String>? headers}) async {
    try {
      var newHeader = await _montarHeader(autoriza);
      if (headers != null) {
        newHeader.addAll(headers);
      }
      var response = await http
          .put(
            Uri.parse('$baseUrl$endpoint'),
            headers: newHeader,
            body: body,
          )
          .timeout(_timeout);
      garantirSucesso(response);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response> get(String endpoint, {bool autoriza = false}) async {
    try {
      var newHeader = await _montarHeader(autoriza);

      var response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: newHeader,
          )
          .timeout(_timeout);
      garantirSucesso(response);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  // Future<void> garantirInternet() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (!connectivityResult.any((element) =>
  //       element == ConnectivityResult.mobile ||
  //       element == ConnectivityResult.wifi)) {
  //     throw BadRequestException.porMensagem(
  //         'Verifique a sua conexão com a internet');
  //   }
  // }

  void garantirSucesso(Response response) {
    switch (response.statusCode) {
      case 200:
        return;
      case HttpStatus.noContent:
        return;
      case 400:
        throw Exception("erro na API");
      case 401:
        throw Exception('Não autorizado');
      case 500:
        throw Exception('Erro interno, tente novamente mais tarde');
      default:
        throw Exception('Erro desconhecido');
    }
  }
}
