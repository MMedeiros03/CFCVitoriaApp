// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valor_servico_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValorServicoRDTO _$ValorServicoRDTOFromJson(Map<String, dynamic> json) =>
    ValorServicoRDTO(
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$ValorServicoRDTOToJson(ValorServicoRDTO instance) =>
    <String, dynamic>{
      'descricao': instance.descricao,
      'valor': instance.valor,
    };
