// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno_rdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlunoRDTO _$AlunoRDTOFromJson(Map<String, dynamic> json) => AlunoRDTO(
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      cpf: json['cpf'] as String,
      dataNascimento: DateTime.parse(json['dataNascimento'] as String),
      documentosAluno: (json['documentosAluno'] as List<dynamic>)
          .map((e) => DocumentoRDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      endereco: json['endereco'] == null
          ? null
          : EnderecoRDTO.fromJson(json['endereco'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlunoRDTOToJson(AlunoRDTO instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'telefone': instance.telefone,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento.toIso8601String(),
      'endereco': instance.endereco,
      'documentosAluno': instance.documentosAluno,
    };
