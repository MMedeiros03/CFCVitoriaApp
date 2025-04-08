// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlunoDTO _$AlunoDTOFromJson(Map<String, dynamic> json) => AlunoDTO(
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      cpf: json['cpf'] as String,
      dataNascimento: DateTime.parse(json['dataNascimento'] as String),
      endereco: EnderecoDTO.fromJson(json['endereco'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlunoDTOToJson(AlunoDTO instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'telefone': instance.telefone,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento.toIso8601String(),
      'endereco': instance.endereco,
    };
