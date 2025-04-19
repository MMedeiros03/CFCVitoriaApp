// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servico_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicoRDTO _$ServicoRDTOFromJson(Map<String, dynamic> json) => ServicoRDTO(
      id: (json['id'] as num).toInt(),
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      pathImage: json['pathImage'] as String,
      anosValidade: (json['anosValidade'] as num).toInt(),
      valorServico: (json['valorServico'] as num).toDouble(),
      valorServicos: (json['valorServicos'] as List<dynamic>)
          .map((e) => ValorServicoRDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicoRDTOToJson(ServicoRDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'descricao': instance.descricao,
      'pathImage': instance.pathImage,
      'anosValidade': instance.anosValidade,
      'valorServico': instance.valorServico,
      'valorServicos': instance.valorServicos,
    };
