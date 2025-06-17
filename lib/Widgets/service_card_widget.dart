import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'base_button_widget.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      required this.index,
      required this.servico,
      required this.controller});

  final int index;
  final ServicoRDTO servico;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    String animationPath = "assets/animations/ServiceAnimation$index.json";

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black12,
        ),
        child: Padding(
            padding: EdgeInsets.only(right: 0, left: 0, top: 16, bottom: 16),
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.4,
                      height: constraints.maxHeight,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Lottie.asset(
                            animationPath,
                            fit: BoxFit.cover,
                            controller: controller,
                            onLoaded: (composition) {
                              controller
                                ..duration = composition.duration
                                ..repeat();
                            },
                          ),
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        spacing: 5,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            height: constraints.maxHeight * 0.3,
                            child: BaseText(
                              text: servico.titulo,
                              size: 17,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            height: constraints.maxHeight * 0.3,
                            child: BaseText(
                              maxLines: 3,
                              overflow: true,
                              bold: false,
                              text: servico.descricao,
                              size: 11,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      BaseButton(
                        width: constraints.maxWidth * 0.35,
                        heigth: constraints.maxHeight * 0.25,
                        colorFont: Colors.black,
                        backgroundColor: Color(0xFFF0733D),
                        text: "Detalhes",
                        fontSize: 14,
                        onPressed: () {
                          Get.toNamed("/servico", arguments: servico);
                        },
                      ),
                    ],
                  ),
                ],
              );
            })));
  }
}
