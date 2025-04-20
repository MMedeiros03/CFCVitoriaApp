import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Documento/documento_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Endereco/endereco_rdto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aluno_rdto.g.dart';

@JsonSerializable()
class AlunoRDTO {
  String nome;
  String email;
  String telefone;
  String cpf;
  DateTime dataNascimento;
  EnderecoRDTO endereco;
  List<DocumentoRDTO> documentosAluno;

  AlunoRDTO(
      {required this.nome,
      required this.email,
      required this.telefone,
      required this.cpf,
      required this.dataNascimento,
      required this.documentosAluno,
      required this.endereco});

  Map<String, dynamic> toJson() => _$AlunoRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AlunoRDTO.fromJson(Map<String, dynamic> json) =>
      _$AlunoRDTOFromJson(json);
}
