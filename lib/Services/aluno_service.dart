import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Aluno/aluno_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Aluno/aluno_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';

class AlunoService extends ApiServiceBase {
  Future<void> cadastrarAluno(AlunoDTO alunoDto) async {
    try {
      var alunoToJson = alunoDto.toJson();
      await post('/Aluno', alunoToJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<AlunoRDTO> obterDadosAluno() async {
    try {
      final response = await get('/Aluno/ObterAlunoLogado', autoriza: true);
      var responseJson = json.decode(response.body);
      return AlunoRDTO.fromJson(responseJson);
    } catch (e) {
      rethrow;
    }
  }
}
