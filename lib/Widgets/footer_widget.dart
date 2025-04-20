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
            spacing: 35,
            children: [
              GestureDetector(
                onTap: () {
                  _redirecionarParaPagina("/servicos");
                },
                child: Icon(
                  Icons.book_outlined,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _validarERedirecionar("/meusDados");
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _validarERedirecionar("/create-agendamento");
                },
                child: Icon(
                  Icons.add_box_outlined,
                  color: Color(0xFFF0733D),
                  size: 45,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _validarERedirecionar("/agendamentos");
                },
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _redirecionarParaPagina("/sobreNos");
                },
                child: Icon(
                  Icons.phone_outlined,
                  size: 35,
                ),
              ),
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
      Get.offNamed(path);
    }
  }

  Future<void> _redirecionarParaPagina(String path) async {
    await Get.toNamed(path);
    return;
  }
}
