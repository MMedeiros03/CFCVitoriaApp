// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoDTO _$AgendamentoDTOFromJson(Map<String, dynamic> json) =>
    AgendamentoDTO(
      alunoId: (json['alunoId'] as num).toInt(),
      servicoId: (json['servicoId'] as num).toInt(),
      dataHoraAgendamento:
          DateTime.parse(json['dataHoraAgendamento'] as String),
      observacao: json['observacao'] as String,
      documentosAluno: (json['documentosAluno'] as List<dynamic>)
          .map((e) => DocumentoDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgendamentoDTOToJson(AgendamentoDTO instance) =>
    <String, dynamic>{
      'alunoId': instance.alunoId,
      'servicoId': instance.servicoId,
      'dataHoraAgendamento': instance.dataHoraAgendamento.toIso8601String(),
      'observacao': instance.observacao,
      'documentosAluno': instance.documentosAluno,
    };
