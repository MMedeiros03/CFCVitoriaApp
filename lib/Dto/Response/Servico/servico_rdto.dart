import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'servico_rdto.g.dart';

@JsonSerializable()
class ServicoRDTO {
  int id;
  String titulo;
  String descricao;
  String pathImage;
  int anosValidade;
  double valorServico;

  ServicoRDTO({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.pathImage,
    required this.anosValidade,
    required this.valorServico,
  });

  Map<String, dynamic> toJson() => _$ServicoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory ServicoRDTO.fromJson(Map<String, dynamic> json) =>
      _$ServicoRDTOFromJson(json);
}
