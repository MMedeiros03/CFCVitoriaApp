// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova_senha_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovaSenhaDTO _$NovaSenhaDTOFromJson(Map<String, dynamic> json) => NovaSenhaDTO(
      novaSenha: json['novaSenha'] as String,
      alunoId: (json['alunoId'] as num).toInt(),
    );

Map<String, dynamic> _$NovaSenhaDTOToJson(NovaSenhaDTO instance) =>
    <String, dynamic>{
      'novaSenha': instance.novaSenha,
      'alunoId': instance.alunoId,
    };
