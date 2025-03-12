// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoDTO _$AgendamentoDTOFromJson(Map<String, dynamic> json) =>
    AgendamentoDTO(
      alunoId: (json['alunoId'] as num).toInt(),
      servicoId: (json['servicoId'] as num).toInt(),
      dataHoraAgendado: DateTime.parse(json['dataHoraAgendado'] as String),
      observacao: json['observacao'] as String,
    );

Map<String, dynamic> _$AgendamentoDTOToJson(AgendamentoDTO instance) =>
    <String, dynamic>{
      'alunoId': instance.alunoId,
      'servicoId': instance.servicoId,
      'dataHoraAgendado': instance.dataHoraAgendado.toIso8601String(),
      'observacao': instance.observacao,
    };
