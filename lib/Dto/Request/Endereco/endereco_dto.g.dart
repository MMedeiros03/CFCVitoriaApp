// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnderecoDTO _$EnderecoDTOFromJson(Map<String, dynamic> json) => EnderecoDTO(
      cep: json['cep'] as String,
      rua: json['rua'] as String,
      numero: json['numero'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
      estado: json['estado'] as String,
    );

Map<String, dynamic> _$EnderecoDTOToJson(EnderecoDTO instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'rua': instance.rua,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'estado': instance.estado,
    };
