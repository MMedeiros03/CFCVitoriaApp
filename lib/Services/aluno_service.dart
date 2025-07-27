import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Aluno/aluno_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Aluno/nova_senha_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Documento/documento_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Aluno/aluno_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Documento/documento_aluno_rdto.dart';
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

  Future<AlunoRDTO> obterDadosAluno() async {
    try {
      final response = await get('/Aluno/ObterAlunoLogado', autoriza: true);
      var responseJson = json.decode(response.body);
      return AlunoRDTO.fromJson(responseJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cadastrarDocumentoAluno(DocumentoDTO documentoAluno) async {
    try {
      final response = await post(
          '/Aluno/CadastrarDocumentoAluno', documentoAluno.toJson(),
          autoriza: true);
      var responseJson = json.decode(response.body);
      var documentosAtualizados = List.generate(responseJson.length, (i) {
        return DocumentoAlunoRDTO.fromJson(responseJson[i]);
      });

      await StorageService.setListaDocumentosAluno(
          jsonEncode(documentosAtualizados));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetarSenhaAluno(String novaSenha) async {
    try {
      var alunoId = await StorageService.getAlunoId();

      var novaSenhaJson = NovaSenhaDTO(alunoId: alunoId!, novaSenha: novaSenha);

      await post('/Aluno/RedefinirSenha', novaSenhaJson.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
