import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Aluno/aluno_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Login/login_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Login/login_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';

class AlunoService extends ApiServiceBase {
  Future<void> cadastrarAluno(AlunoDTO alunoDto) async {
    try {
      var alunoToJson = alunoDto.toJson();
      await post('/Aluno', alunoToJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> obterDadosAluno(LoginDTO loginDto) async {
    try {
      var loginToJson = loginDto.toJson();
      final response = await post('/Login', loginToJson);
      var responseJson = json.decode(response.body);
      var loginResponseDto = LoginRDTO.fromJson(responseJson);
      return await StorageService.setToken(loginResponseDto.accessToken, true);
    } catch (e) {
      rethrow;
    }
  }
}
