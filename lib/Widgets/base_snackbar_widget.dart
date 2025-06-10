import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseSnackbar {
  static SnackbarController exibirNotificacao(
      String titulo, String mensagem, bool sucesso) {
    return Get.snackbar(sucesso ? "Sucesso" : "Erro", mensagem,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        colorText: Colors.white,
        backgroundColor: sucesso
            ? const Color.fromARGB(207, 70, 172, 74)
            : const Color.fromARGB(207, 173, 30, 30));
  }

  static SnackbarController exibirDica(String mensagem) {
    return Get.snackbar("Dica", mensagem,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        colorText: Colors.black,
        backgroundColor: const Color.fromARGB(207, 240, 224, 2));
  }
}
