// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documento_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentoDTO _$DocumentoDTOFromJson(Map<String, dynamic> json) => DocumentoDTO(
      tipoDocumento: (json['tipoDocumento'] as num).toInt(),
      nomeArquivo: json['nomeArquivo'] as String,
      pathDocumento: json['pathDocumento'] as String,
    );

Map<String, dynamic> _$DocumentoDTOToJson(DocumentoDTO instance) =>
    <String, dynamic>{
      'tipoDocumento': instance.tipoDocumento,
      'nomeArquivo': instance.nomeArquivo,
      'pathDocumento': instance.pathDocumento,
    };
