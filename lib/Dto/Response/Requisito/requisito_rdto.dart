import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'requisito_rdto.g.dart';

@JsonSerializable()
class RequisitoRDTO {
  String descricao;
  int id;

  RequisitoRDTO({
    required this.descricao,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$RequisitoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory RequisitoRDTO.fromJson(Map<String, dynamic> json) =>
      _$RequisitoRDTOFromJson(json);
}
