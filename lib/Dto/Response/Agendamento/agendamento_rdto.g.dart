// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoRDTO _$AgendamentoRDTOFromJson(Map<String, dynamic> json) =>
    AgendamentoRDTO(
      id: (json['id'] as num).toInt(),
      alunoId: (json['alunoId'] as num).toInt(),
      servicoId: (json['servicoId'] as num).toInt(),
      cancelado: json['cancelado'] as bool,
      dataHoraAgendado: DateTime.parse(json['dataHoraAgendado'] as String),
      observacao: json['observacao'] as String,
    );

Map<String, dynamic> _$AgendamentoRDTOToJson(AgendamentoRDTO instance) =>
    <String, dynamic>{
      'alunoId': instance.alunoId,
      'id': instance.id,
      'servicoId': instance.servicoId,
      'cancelado': instance.cancelado,
      'dataHoraAgendado': instance.dataHoraAgendado.toIso8601String(),
      'observacao': instance.observacao,
    };
