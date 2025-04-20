import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'documento_rdto.g.dart';

@JsonSerializable()
class DocumentoRDTO {
  int id;
  String pathDocumento;

  DocumentoRDTO({
    required this.id,
    required this.pathDocumento,
  });

  Map<String, dynamic> toJson() => _$DocumentoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory DocumentoRDTO.fromJson(Map<String, dynamic> json) =>
      _$DocumentoRDTOFromJson(json);
}
