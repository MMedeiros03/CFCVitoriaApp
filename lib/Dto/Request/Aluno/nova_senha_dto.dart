import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'nova_senha_dto.g.dart';

@JsonSerializable()
class NovaSenhaDTO {
  final String novaSenha;
  final int alunoId;

  NovaSenhaDTO({
    required this.novaSenha,
    required this.alunoId,
  });

  Map<String, dynamic> toJson() => _$NovaSenhaDTOToJson(this);
  NovaSenhaDTO toMap(Map<String, dynamic> map) => _$NovaSenhaDTOFromJson(map);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
