import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'endereco_rdto.g.dart';

@JsonSerializable()
class EnderecoRDTO {
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;

  EnderecoRDTO({
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
  });

  Map<String, dynamic> toJson() => _$EnderecoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory EnderecoRDTO.fromJson(Map<String, dynamic> json) =>
      _$EnderecoRDTOFromJson(json);
}
