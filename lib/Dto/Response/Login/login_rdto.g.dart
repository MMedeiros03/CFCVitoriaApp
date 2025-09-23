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
      solicitouResetSenha: json['solicitouResetSenha'] as bool,
      documentosAluno: (json['documentosAluno'] as List<dynamic>)
          .map((e) => DocumentoAlunoRDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginRDTOToJson(LoginRDTO instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'alunoId': instance.alunoId,
      'nomeAluno': instance.nomeAluno,
      'solicitouResetSenha': instance.solicitouResetSenha,
      'documentosAluno': instance.documentosAluno,
    };
