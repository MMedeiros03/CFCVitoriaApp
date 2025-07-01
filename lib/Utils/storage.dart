import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Documento/documento_aluno_rdto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = "_tokenKey";
  static const _alunoId = "_alunoId";
  static const _alunoNome = "_alunoNome";
  static const _viewedTutorial = "_viewedTutorial";
  static const _proximoAgendamento = "_proximoAgendamento";
  static const _listaDocumentosAluno = "_listaDocumentosAluno";
  static const _aceitouTermo = "_aceitouTermo";

  static Future<void> remover(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> setToken(String token, bool criptografado) async {
    if (criptografado) {
      const storage = FlutterSecureStorage();
      await storage.write(key: _tokenKey, value: token);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    }
  }

  static Future<String?> getToken(bool criptografado) async {
    if (criptografado) {
      const storage = FlutterSecureStorage();
      return await storage.read(key: _tokenKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    }
  }

  static Future<void> setAlunoId(int alunoId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_alunoId, alunoId);
  }

  static Future<int?> getAlunoId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_alunoId);
  }

  static Future<void> setAlunoNome(String alunoNome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_alunoNome, alunoNome);
  }

  static Future<String?> getAlunoNome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_alunoNome);
  }

  static Future<void> removeToken(bool criptografado) async {
    if (criptografado) {
      const storage = FlutterSecureStorage();
      await storage.delete(key: _tokenKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    }
  }

  static Future<void> removeAlunoId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_alunoId);
  }

  static Future<void> setVisualizedTutorial(bool visualizou) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_viewedTutorial, visualizou.toString());
  }

  static Future<bool> getVisualizedTutorial() async {
    final prefs = await SharedPreferences.getInstance();

    var teste = prefs.getString(_viewedTutorial);

    return teste == "true";
  }

  static Future<void> removeProximoAgendamento() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_proximoAgendamento);
  }

  static Future<void> setProximoAgendamento(
      String jsonProximoAgendamento) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_proximoAgendamento);

    await prefs.setString(_proximoAgendamento, jsonProximoAgendamento);
  }

  static Future<AgendamentoRDTO?> getProximoAgendamento() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var proximoAgendamento = prefs.getString(_proximoAgendamento);

      if (proximoAgendamento != null && proximoAgendamento != "") {
        var agendamentoJson = json.decode(proximoAgendamento);

        var proximoAgendamentoAluno = AgendamentoRDTO.fromJson(agendamentoJson);

        return proximoAgendamentoAluno;
      }

      return null;
    } catch (ex) {
      return null;
    }
  }

  static Future<void> removeListaDocumentosAluno() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_listaDocumentosAluno);
  }

  static Future<void> setListaDocumentosAluno(
      String jsonListaDocumentosAluno) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_listaDocumentosAluno);

    await prefs.setString(_listaDocumentosAluno, jsonListaDocumentosAluno);
  }

  static Future<List<DocumentoAlunoRDTO>> getListaDocumentosAluno() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var listaDocumentosAlunoString = prefs.getString(_listaDocumentosAluno);

      if (listaDocumentosAlunoString != null &&
          listaDocumentosAlunoString != "") {
        var listaDocumentosAluno = json.decode(listaDocumentosAlunoString);

        return List.generate(listaDocumentosAluno.length, (i) {
          return DocumentoAlunoRDTO.fromJson(listaDocumentosAluno[i]);
        });
      }

      return [];
    } catch (ex) {
      return [];
    }
  }

  static Future<void> setAceitouTermo(bool aceitou) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_aceitouTermo, aceitou);
  }

  static Future<bool> getAceitouTermo() async {
    final prefs = await SharedPreferences.getInstance();

    var aceitouTermo = prefs.getBool(_aceitouTermo);

    return aceitouTermo ?? false;
  }
}
