import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alterar_agendamento_dto.g.dart';

@JsonSerializable()
class AlterarAgendamentoDTO {
  int agendamentoId;
  int novaSituacao;
  DateTime? dataRemercado;

  AlterarAgendamentoDTO({
    required this.agendamentoId,
    required this.novaSituacao,
    required this.dataRemercado,
  });

  Map<String, dynamic> toJson() => _$AlterarAgendamentoDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AlterarAgendamentoDTO.fromJson(Map<String, dynamic> json) =>
      _$AlterarAgendamentoDTOFromJson(json);
}
