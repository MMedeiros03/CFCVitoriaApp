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

  static String formataCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    if (cpf.length != 11) return cpf;
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

  static String formataNumeroCelular(String numero) {
    numero = numero.replaceAll(RegExp(r'\D'), '');
    if (numero.length == 11) {
      return '(${numero.substring(0, 2)}) ${numero.substring(2, 7)}-${numero.substring(7)}';
    } else if (numero.length == 10) {
      return '(${numero.substring(0, 2)}) ${numero.substring(2, 6)}-${numero.substring(6)}';
    } else {
      return numero;
    }
  }

  static bool ehEmailValido(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return regex.hasMatch(email);
  }

  static String cpfParaSenha(String cpf) {
    String somenteNumeros = cpf.replaceAll(RegExp(r'\D'), '');

    if (somenteNumeros.length >= 8) {
      return somenteNumeros.substring(0, 8);
    } else {
      return somenteNumeros;
    }
  }

  static bool validarCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11 || cpf == "00000000000") return false;

    int soma = 0;
    int resto;

    for (int i = 1; i <= 9; i++) {
      soma += int.parse(cpf.substring(i - 1, i)) * (11 - i);
    }

    resto = (soma * 10) % 11;
    if (resto == 10 || resto == 11) resto = 0;

    if (resto != int.parse(cpf.substring(9, 10))) return false;

    soma = 0;
    for (int i = 1; i <= 10; i++) {
      soma += int.parse(cpf.substring(i - 1, i)) * (12 - i);
    }

    resto = (soma * 10) % 11;
    if (resto == 10 || resto == 11) resto = 0;

    if (resto != int.parse(cpf.substring(10, 11))) return false;

    return true;
  }
}
