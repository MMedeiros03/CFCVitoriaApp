import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_button_widget.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.servico,
  });

  final ServicoRDTO servico;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black12,
        ),
        child: Padding(
            padding: EdgeInsets.only(right: 0, left: 0, top: 16, bottom: 16),
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 145,
                    height: 145,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/image/logo_medeiros.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        spacing: 5,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: BaseText(
                              text: servico.titulo,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: BaseText(
                              maxLines: 3,
                              overflow: true,
                              text: servico.descricao,
                              size: 8,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      BaseButton(
                        width: 125,
                        heigth: 40,
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
