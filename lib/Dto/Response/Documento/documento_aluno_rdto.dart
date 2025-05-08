import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'documento_aluno_rdto.g.dart';

@JsonSerializable()
class DocumentoAlunoRDTO {
  int tipoDocumento;

  DocumentoAlunoRDTO({
    required this.tipoDocumento,
  });

  Map<String, dynamic> toJson() => _$DocumentoAlunoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory DocumentoAlunoRDTO.fromJson(Map<String, dynamic> json) =>
      _$DocumentoAlunoRDTOFromJson(json);
}
