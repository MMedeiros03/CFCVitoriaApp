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
          decoration: const BoxDecoration(
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
                  Icons.design_services_outlined,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _redirecionarParaPagina("/sobreNos");
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _redirecionarParaPagina("/agendamento");
                },
                child: Icon(
                  Icons.add_box_outlined,
                  size: 45,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _redirecionarParaPagina("/agendamentos");
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

  Future<void> _redirecionarParaPagina(String path) async {
    await Get.toNamed(path);
    return;
  }
}
