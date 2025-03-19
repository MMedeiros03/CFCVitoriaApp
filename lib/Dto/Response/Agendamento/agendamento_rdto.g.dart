// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoRDTO _$AgendamentoRDTOFromJson(Map<String, dynamic> json) =>
    AgendamentoRDTO(
      dataHoraAgendado: DateTime.parse(json['dataHoraAgendado'] as String),
      contagemDias: json['contagemDias'] as String,
      situacaoAgendamento: json['situacaoAgendamento'] as String,
      observacao: json['observacao'] as String,
      servico: ServicoRDTO.fromJson(json['servico'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgendamentoRDTOToJson(AgendamentoRDTO instance) =>
    <String, dynamic>{
      'dataHoraAgendado': instance.dataHoraAgendado.toIso8601String(),
      'contagemDias': instance.contagemDias,
      'situacaoAgendamento': instance.situacaoAgendamento,
      'observacao': instance.observacao,
      'servico': instance.servico,
    };
