import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_rdto.g.dart';

@JsonSerializable()
class LoginRDTO {
  final String accessToken;
  final String tokenType;
  final int alunoId;

  LoginRDTO(
      {required this.accessToken,
      required this.tokenType,
      required this.alunoId});

  Map<String, dynamic> toJson() => _$LoginRDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory LoginRDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRDTOFromJson(json);
}
