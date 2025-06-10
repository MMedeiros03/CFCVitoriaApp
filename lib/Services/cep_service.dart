import 'dart:convert';
import 'package:cfc_vitoria_app/Dto/Response/Cep/cep_rdto.dart';
import 'package:http/http.dart' as http;

class CepService {

  static Future<CepRDTO?> buscarEnderecoPorCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('erro')) return null;

      return CepRDTO.fromJson(jsonDecode(response.body));

    } else {
      return null;
    }
  }

}