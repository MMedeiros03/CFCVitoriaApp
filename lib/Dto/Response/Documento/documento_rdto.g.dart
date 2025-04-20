// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documento_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentoRDTO _$DocumentoRDTOFromJson(Map<String, dynamic> json) =>
    DocumentoRDTO(
      id: (json['id'] as num).toInt(),
      pathDocumento: json['pathDocumento'] as String,
    );

Map<String, dynamic> _$DocumentoRDTOToJson(DocumentoRDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pathDocumento': instance.pathDocumento,
    };
