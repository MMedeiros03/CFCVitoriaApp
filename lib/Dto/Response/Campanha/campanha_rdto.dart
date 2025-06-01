import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'campanha_rdto.g.dart';

@JsonSerializable()
class CampanhaRDTO {
  String titulo;
  String descricao;
  String pathImage;

  CampanhaRDTO({
    required this.titulo,
    required this.descricao,
    required this.pathImage,
  });

  Map<String, dynamic> toJson() => _$CampanhaRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory CampanhaRDTO.fromJson(Map<String, dynamic> json) =>
      _$CampanhaRDTOFromJson(json);
}
