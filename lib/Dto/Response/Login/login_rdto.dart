import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Documento/documento_aluno_rdto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_rdto.g.dart';

@JsonSerializable()
class LoginRDTO {
  final String accessToken;
  final String tokenType;
  final int alunoId;
  final String nomeAluno;
  final bool solicitouResetSenha;
  final AgendamentoRDTO? proximoAgendamentoAluno;
  final List<DocumentoAlunoRDTO> documentosAluno;

  LoginRDTO({
    required this.accessToken,
    required this.tokenType,
    required this.alunoId,
    required this.nomeAluno,
    required this.solicitouResetSenha,
    this.proximoAgendamentoAluno,
    required this.documentosAluno,
  });

  Map<String, dynamic> toJson() => _$LoginRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory LoginRDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRDTOFromJson(json);
}
