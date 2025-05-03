import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Utils {
  static Future<bool> validaToken() async {
    if (Get.currentRoute == "/login") {
      return true;
    }

    var tokenSalvo = await StorageService.getToken(true);

    if (tokenSalvo == null) {
      return false;
    }

    return !JwtDecoder.isExpired(tokenSalvo);
  }

  static Future<File> renomearArquivo(File arquivo, String novoNome) async {
    String caminhoOriginal = arquivo.path;
    String diretorio = p.dirname(caminhoOriginal);
    String extensao = p.extension(caminhoOriginal);

    String novoCaminho = p.join(diretorio, '$novoNome$extensao');

    return await arquivo.rename(novoCaminho);
  }
}
