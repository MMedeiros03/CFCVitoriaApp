import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agendamento_rdto.g.dart';

@JsonSerializable()
class AgendamentoRDTO {
  DateTime dataHoraAgendado;
  String contagemDias;
  String situacaoAgendamento;
  String observacao;
  ServicoRDTO servico;

  AgendamentoRDTO({
    required this.dataHoraAgendado,
    required this.contagemDias,
    required this.situacaoAgendamento,
    required this.observacao,
    required this.servico,
  });

  Map<String, dynamic> toJson() => _$AgendamentoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AgendamentoRDTO.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoRDTOFromJson(json);
}
