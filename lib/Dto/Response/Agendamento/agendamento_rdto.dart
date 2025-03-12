import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'agendamento_rdto.g.dart';

@JsonSerializable()
class AgendamentoRDTO {
  int alunoId;
  int id;
  int servicoId;
  bool cancelado;
  DateTime dataHoraAgendado;
  String observacao;

  AgendamentoRDTO({
    required this.id,
    required this.alunoId,
    required this.servicoId,
    required this.cancelado,
    required this.dataHoraAgendado,
    required this.observacao,
  });

  Map<String, dynamic> toJson() => _$AgendamentoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AgendamentoRDTO.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoRDTOFromJson(json);
}
