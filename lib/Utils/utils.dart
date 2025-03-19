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
}
