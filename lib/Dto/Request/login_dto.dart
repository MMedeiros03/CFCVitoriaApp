import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final String login;
  final String password;

  LoginDTO({required this.login, required this.password});

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
