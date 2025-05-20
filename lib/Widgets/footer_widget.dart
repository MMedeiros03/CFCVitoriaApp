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
        padding: const EdgeInsets.all(14),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              GestureDetector(
                  onTap: () {
                    _redirecionarParaPagina("/servicos");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: defineCorPelaRota("/servicos"),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.book_outlined,
                          size: 35,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    _validarERedirecionar("/meusDados");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: defineCorPelaRota("/meusDados"),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.person_outlined,
                          size: 35,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    _validarERedirecionar("/create-agendamento");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: defineCorPelaRota("/create-agendamento"),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.add_box_outlined,
                          size: 35,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    _validarERedirecionar("/agendamentos");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: defineCorPelaRota("/agendamentos"),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 35,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    _redirecionarParaPagina("/sobreNos");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: defineCorPelaRota("/sobreNos"),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.phone_outlined,
                          size: 35,
                        ),
                      ))),
            ],
          ),
        ));
  }

  Future _validarERedirecionar(path) async {
    var tokenValido = await Utils.validaToken();

    if (mounted) {
      Scaffold.of(context).closeDrawer();
    }

    if (!tokenValido) {
      Get.toNamed("/login",
          arguments: "Você precisa fazer o login para visualizar seus dados");
    } else {
      Get.toNamed(path);
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

  Future<void> _redirecionarParaPagina(String path) async {
    await Get.toNamed(path);
    return;
  }
}
