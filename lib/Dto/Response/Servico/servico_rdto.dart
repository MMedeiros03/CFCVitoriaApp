import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Requisito/requisito_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/ValorServico/valor_servico_rdto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'servico_rdto.g.dart';

@JsonSerializable()
class ServicoRDTO {
  int id;
  String titulo;
  String descricao;
  String pathImage;
  String anosValidade;
  bool exigeCPF;
  bool exigeCNH;
  double valorServico;
  List<ValorServicoRDTO> valorServicos;
  List<RequisitoRDTO> requisitos;

  ServicoRDTO(
      {required this.id,
      required this.titulo,
      required this.descricao,
      required this.pathImage,
      required this.anosValidade,
      required this.exigeCPF,
      required this.exigeCNH,
      required this.valorServico,
      required this.requisitos,
      required this.valorServicos});

  Map<String, dynamic> toJson() => _$ServicoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory ServicoRDTO.fromJson(Map<String, dynamic> json) =>
      _$ServicoRDTOFromJson(json);
}
