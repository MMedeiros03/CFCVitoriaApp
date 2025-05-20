// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requisito_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequisitoRDTO _$RequisitoRDTOFromJson(Map<String, dynamic> json) =>
    RequisitoRDTO(
      descricao: json['descricao'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$RequisitoRDTOToJson(RequisitoRDTO instance) =>
    <String, dynamic>{
      'descricao': instance.descricao,
      'id': instance.id,
    };
