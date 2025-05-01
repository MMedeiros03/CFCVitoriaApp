import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Documento/documento_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agendamento_dto.g.dart';

@JsonSerializable()
class AgendamentoDTO {
  int alunoId;
  int servicoId;
  DateTime dataHoraAgendamento;
  String observacao;
  List<DocumentoDTO> documentosAluno = [];

  AgendamentoDTO(
      {required this.alunoId,
      required this.servicoId,
      required this.dataHoraAgendamento,
      required this.observacao,
      required this.documentosAluno});

  Map<String, dynamic> toJson() => _$AgendamentoDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AgendamentoDTO.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoDTOFromJson(json);
}
