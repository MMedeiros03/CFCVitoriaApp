// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRDTO _$LoginRDTOFromJson(Map<String, dynamic> json) => LoginRDTO(
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String,
      alunoId: (json['alunoId'] as num).toInt(),
      nomeAluno: json['nomeAluno'] as String,
      proximoAgendamentoAluno: json['proximoAgendamentoAluno'] == null
          ? null
          : AgendamentoRDTO.fromJson(
              json['proximoAgendamentoAluno'] as Map<String, dynamic>),
      documentosAluno: (json['documentosAluno'] as List<dynamic>)
          .map((e) => DocumentoAlunoRDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginRDTOToJson(LoginRDTO instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'alunoId': instance.alunoId,
      'nomeAluno': instance.nomeAluno,
      'proximoAgendamentoAluno': instance.proximoAgendamentoAluno,
      'documentosAluno': instance.documentosAluno,
    };
