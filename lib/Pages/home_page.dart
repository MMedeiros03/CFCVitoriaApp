import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/home_card_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late bool usuarioLogado = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _inicializar();
  }

  _inicializar() async {
    var token = await StorageService.getToken(true);

    setState(() {
      usuarioLogado = token?.isNotEmpty ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(
                Icons.person_outlined,
                size: 55,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: "Bem vindo,",
                    bold: true,
                    size: 17,
                    color: Colors.black,
                  ),
                  BaseText(
                    text: "aluno!",
                    bold: false,
                    size: 17,
                    color: Colors.black,
                  ),
                ],
              )
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: alturaTela * 0.24,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5)),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: larguraTela,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.black12),
                      child: BaseText(
                        text: 'imagem $i',
                        size: 16,
                        bold: false,
                        color: Colors.black,
                      ));
                },
              );
            }).toList(),
          ),
          if (usuarioLogado)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                BaseText(
                    text: "Próximo Agendamento ",
                    size: 20,
                    bold: true,
                    color: Colors.black),
                Container(
                  width: larguraTela,
                  height: alturaTela * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 50,
                        color: Color(0xFFF0733D),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BaseText(
                              text: "20/10/2025 - 13:30",
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(height: 4),
                            BaseText(
                              text: "Faltam 5 dias para a visita.",
                              size: 12,
                              color: Colors.black45,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: BaseButton(
                          width: 110,
                          heigth: 35,
                          colorFont: Colors.black,
                          backgroundColor: Color(0xFFF0733D),
                          text: "Ver",
                          fontSize: 14,
                          onPressed: () {
                            Get.toNamed("servico");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
              controller: _controller,
              path: "/servicos",
              title: "Serviços",
              description: "Serviços",
              pathAnimation: 'assets/animations/LearnAnimation.json',
            ),
          ),
          if (!usuarioLogado)
            SizedBox(
              width: larguraTela,
              height: alturaTela * 0.12,
              child: HomeCardAnimation(
                controller: _controller,
                path: "/agendamentos",
                title: "Agendamentos",
                description: "Agende sua consulta!",
                pathAnimation: 'assets/animations/CalendarAnimation.json',
              ),
            ),
          SizedBox(
              width: larguraTela,
              height: alturaTela * 0.12,
              child: HomeCardAnimation(
                controller: _controller,
                path: "/sobreNos",
                title: "Sobre nós",
                description: "Sobre nós",
                pathAnimation: 'assets/animations/AboutAnimation.json',
              )),
        ],
      ),
    );
  }
}
