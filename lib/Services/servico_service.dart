import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';

class ServicoService extends ApiServiceBase {
  Future<List<ServicoRDTO>> getAll() async {
    try {
      final response = await get('/Servico', autoriza: false);
      var responseJson = json.decode(response.body);
      return List.generate(responseJson.length, (i) {
        return ServicoRDTO.fromJson(responseJson[i]);
      });
    } catch (e) {
      return [];
    }
  }
}
