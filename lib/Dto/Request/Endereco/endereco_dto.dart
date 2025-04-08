import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'endereco_dto.g.dart';

@JsonSerializable()
class EnderecoDTO {
  final String cep;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;

  EnderecoDTO({
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });

  Map<String, dynamic> toJson() => _$EnderecoDTOToJson(this);

  EnderecoDTO toMap(Map<String, dynamic> map) => _$EnderecoDTOFromJson(map);

  static EnderecoDTO fromJson(Map<String, dynamic> map) {
    return EnderecoDTO(
        cep: map["cep"],
        bairro: map["bairro"],
        cidade: map["cidade"],
        estado: map["estado"],
        numero: map["numero"],
        rua: map["rua"]);
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
