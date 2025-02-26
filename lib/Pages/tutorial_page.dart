import 'package:cfc_vitoria_app/Utils/loading.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/base_text_widget.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<StatefulWidget> createState() => TutorialPageState();
}

class TutorialPageState extends State<TutorialPage> {
  int currentStep = 1;

  Widget _buildStepIndicator(int step) {
    return Container(
      width: currentStep == step ? 70 : 40,
      height: 20,
      decoration: BoxDecoration(
          color: Color(0xFFF0733D),
          shape: currentStep == step ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: currentStep == step ? BorderRadius.circular(12) : null),
    );
  }

  Widget? _printContentTutorial() {
    switch (currentStep) {
      case 1:
        return Column(
          spacing: 25,
          children: [
            Icon(Icons.person_outline, size: 120, color: Color(0xFFF0733D)),
            BaseText(
              text: "Faça seu cadastro",
              size: 30,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: BaseText(
                text:
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                size: 18,
                bold: false,
                color: Colors.black54,
                alignText: true,
              ),
            )
          ],
        );
      case 2:
        return Column(
          spacing: 20,
          children: [
            Icon(Icons.book_outlined, size: 120, color: Color(0xFFF0733D)),
            BaseText(
              text: "Conheça nossos serviços",
              size: 24,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: BaseText(
                text:
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                size: 18,
                bold: false,
                color: Colors.black54,
                alignText: true,
              ),
            )
          ],
        );
      case 3:
        return Column(
          spacing: 20,
          children: [
            Icon(Icons.add_box_outlined, size: 120, color: Color(0xFFF0733D)),
            BaseText(
              text: "Agende um horário",
              size: 24,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: BaseText(
                text:
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
                size: 18,
                bold: false,
                color: Colors.black54,
                alignText: true,
              ),
            )
          ],
        );
    }
    return null;
  }

  _redirectToHome() async {
    final loadingController = Get.find<LoadingController>();
    loadingController.showLoading();

    await Future.delayed(Duration(milliseconds: 300));

    await Get.offAndToNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          color: Color(0xFFE8E8E8),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: alturaTela * 0.06,
                top: alturaTela * 0.08,
                left: 20,
                right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepIndicator(1),
                    _buildStepIndicator(2),
                    _buildStepIndicator(3),
                  ],
                ),
                SizedBox(child: _printContentTutorial()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                        text: "Pular",
                        color: currentStep != 3
                            ? Colors.black38
                            : Colors.transparent,
                        size: 12,
                        onClick: _redirectToHome),
                    BaseButton(
                      width: 150,
                      heigth: 45,
                      onPressed: () {
                        if (currentStep != 3) {
                          setState(() {
                            currentStep = currentStep + 1;
                          });
                        } else {
                          _redirectToHome();
                        }
                      },
                      fontSize: 12,
                      text: currentStep == 3 ? "Iniciar" : "Proximo",
                      backgroundColor: Color(0xFFF0733D),
                      colorFont: Colors.black,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
