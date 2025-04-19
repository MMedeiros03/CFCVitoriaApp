import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'valor_servico_rdto.g.dart';

@JsonSerializable()
class ValorServicoRDTO {
  String descricao;
  double valor;

  ValorServicoRDTO({
    required this.descricao,
    required this.valor,
  });

  Map<String, dynamic> toJson() => _$ValorServicoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory ValorServicoRDTO.fromJson(Map<String, dynamic> json) =>
      _$ValorServicoRDTOFromJson(json);
}
