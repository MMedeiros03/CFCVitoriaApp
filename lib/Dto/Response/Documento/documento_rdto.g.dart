// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documento_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentoRDTO _$DocumentoRDTOFromJson(Map<String, dynamic> json) =>
    DocumentoRDTO(
      id: (json['id'] as num).toInt(),
      pathDocumento: json['pathDocumento'] as String,
      nomeArquivo: json['nomeArquivo'] as String,
      tipoDocumento: (json['tipoDocumento'] as num).toInt(),
    );

Map<String, dynamic> _$DocumentoRDTOToJson(DocumentoRDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nomeArquivo': instance.nomeArquivo,
      'pathDocumento': instance.pathDocumento,
      'tipoDocumento': instance.tipoDocumento,
    };
