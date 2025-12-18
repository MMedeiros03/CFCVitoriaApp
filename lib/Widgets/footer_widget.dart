import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItem(
                Icons.book_outlined, "/servicos", _redirecionarParaPagina),
            _buildItem(
                Icons.person_outlined, "/meusDados", _validarERedirecionar),
            _buildItem(Icons.add_box_outlined, "/create-agendamento",
                _validarERedirecionar),
            _buildItem(Icons.calendar_today_outlined, "/agendamentos",
                _validarERedirecionar),
            _buildItem(
                Icons.phone_outlined, "/sobreNos", _redirecionarParaPagina),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String rota, Function(String) onTap) {
    final larguraTela = MediaQuery.of(context).size.width;

    return Expanded(
      child: GestureDetector(
          onTap: () => onTap(rota),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                color: defineCorPelaRota(rota),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Icon(icon, size: larguraTela * 0.07),
              ),
            ),
          )),
    );
  }

  Future _validarERedirecionar(path) async {
    var tokenValido = await Utils.validaToken();

    if (mounted) {
      Scaffold.of(context).closeDrawer();
    }

    if (!tokenValido) {
      Get.offNamed("/login",
          arguments: "Você precisa fazer o login para visualizar seus dados");
    } else {
      Get.offNamed(path);
    }
  }

  Color defineCorPelaRota(String path) {
    var rotaAtual = Get.currentRoute;

    if (rotaAtual == path) {
      return Color.fromARGB(108, 240, 115, 61);
    } else {
      return Colors.transparent;
    }
  }

  void _redirecionarParaPagina(String path) {
    Get.offNamed(path);
    return;
  }
}
