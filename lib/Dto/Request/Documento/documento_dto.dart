import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'documento_dto.g.dart';

@JsonSerializable()
class DocumentoDTO {
  int alunoId;
  int tipoDocumento;
  String nomeArquivo;
  String pathDocumento;

  DocumentoDTO({
    required this.alunoId,
    required this.tipoDocumento,
    required this.nomeArquivo,
    required this.pathDocumento,
  });

  Map<String, dynamic> toJson() => _$DocumentoDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory DocumentoDTO.fromJson(Map<String, dynamic> json) =>
      _$DocumentoDTOFromJson(json);
}
