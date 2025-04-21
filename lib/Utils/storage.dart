import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = "_tokenKey";
  static const _alunoId = "_alunoId";
  static const _viewedTutorial = "_viewedTutorial";

  static Future<void> remover(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<void> setToken(String token, bool criptografado) async {
    if (criptografado) {
      const storage = FlutterSecureStorage();
      await storage.write(key: _tokenKey, value: token);
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_tokenKey, token);
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
    prefs.setInt(_alunoId, alunoId);
  }

  static Future<int?> getAlunoId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_alunoId);
  }

  static Future<void> removeToken(bool criptografado) async {
    if (criptografado) {
      const storage = FlutterSecureStorage();
      await storage.delete(key: _tokenKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(_tokenKey);
    }
  }

  static Future<void> removeAlunoId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_alunoId);
  }

  static Future<void> setVisualizedTutorial(bool visualizou) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_viewedTutorial, visualizou.toString());
  }

  static Future<bool> getVisualizedTutorial() async {
    final prefs = await SharedPreferences.getInstance();

    var teste = prefs.getString(_viewedTutorial);

    return teste == "true";
  }
}
