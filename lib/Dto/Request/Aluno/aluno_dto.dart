import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Endereco/endereco_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aluno_dto.g.dart';

@JsonSerializable()
class AlunoDTO {
  final String nome;
  final String email;
  final String telefone;
  final String cpf;
  final DateTime dataNascimento;
  final EnderecoDTO endereco;

  AlunoDTO({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.dataNascimento,
    required this.endereco,
  });

  Map<String, dynamic> toJson() => _$AlunoDTOToJson(this);
  AlunoDTO toMap(Map<String, dynamic> map) => _$AlunoDTOFromJson(map);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
