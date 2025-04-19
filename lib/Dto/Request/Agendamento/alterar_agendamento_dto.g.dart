// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alterar_agendamento_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlterarAgendamentoDTO _$AlterarAgendamentoDTOFromJson(
        Map<String, dynamic> json) =>
    AlterarAgendamentoDTO(
      agendamentoId: (json['agendamentoId'] as num).toInt(),
      novaSituacao: (json['novaSituacao'] as num).toInt(),
      dataRemercado: json['dataRemercado'] == null
          ? null
          : DateTime.parse(json['dataRemercado'] as String),
    );

Map<String, dynamic> _$AlterarAgendamentoDTOToJson(
        AlterarAgendamentoDTO instance) =>
    <String, dynamic>{
      'agendamentoId': instance.agendamentoId,
      'novaSituacao': instance.novaSituacao,
      'dataRemercado': instance.dataRemercado?.toIso8601String(),
    };
