// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnderecoRDTO _$EnderecoRDTOFromJson(Map<String, dynamic> json) => EnderecoRDTO(
      cep: json['cep'] as String,
      rua: json['rua'] as String,
      numero: json['numero'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
    );

Map<String, dynamic> _$EnderecoRDTOToJson(EnderecoRDTO instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'rua': instance.rua,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
    };
