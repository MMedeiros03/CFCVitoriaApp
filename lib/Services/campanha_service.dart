import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Campanha/campanha_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';

class CampanhaService extends ApiServiceBase {
  Future<List<CampanhaRDTO>> obterCampanhas() async {
    try {
      final response = await get('/Campanha', autoriza: false);
      var responseJson = json.decode(response.body);
      return List.generate(responseJson.length, (i) {
        return CampanhaRDTO.fromJson(responseJson[i]);
      });
    } catch (e) {
      return [];
    }
  }
}
