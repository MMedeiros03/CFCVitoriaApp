import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Login/login_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Login/login_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';

class LoginService extends ApiServiceBase {
  Future<void> login(LoginDTO loginDto) async {
    try {
      var loginToJson = loginDto.toJson();
      final response = await post('/Login', loginToJson);
      var responseJson = json.decode(response.body);
      var loginResponseDto = LoginRDTO.fromJson(responseJson);
      await StorageService.setAlunoId(loginResponseDto.alunoId);
      return await StorageService.setToken(loginResponseDto.accessToken, true);
    } catch (e) {
      rethrow;
    }
  }
}
