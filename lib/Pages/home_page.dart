import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Utils/loading.dart';
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

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loadingController = Get.find<LoadingController>();
      if (loadingController.isLoading.value) {
        loadingController.hideLoading();
      }
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
          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
              path: "/servicos",
              title: "Serviços",
              description: "Serviços",
              pathAnimation: 'assets/animations/LearnAnimation.json',
            ),
          ),
          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
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
