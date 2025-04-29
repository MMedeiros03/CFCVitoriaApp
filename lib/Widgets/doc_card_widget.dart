import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

import 'base_button_widget.dart';

class DocCard extends StatelessWidget {
  const DocCard(
      {super.key,
      required this.capturarImagem,
      required this.tituloDocumento,
      required this.exibeBotaoCapturaImagem});

  final String tituloDocumento;
  final Function capturarImagem;
  final bool exibeBotaoCapturaImagem;

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;

    return Container(
        height: alturaTela * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black12,
        ),
        child: Padding(
            padding: EdgeInsets.all(12),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: Color(0xFFF0733D),
                        size: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          BaseText(
                              text: tituloDocumento,
                              size: 20,
                              color: Colors.black),
                          SizedBox(
                            width: constraints.maxWidth * 0.75,
                            child: BaseText(
                              maxLines: 2,
                              overflow: true,
                              text:
                                  "Capture uma nova foto ou escolha uma imagem da galeria",
                              size: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (exibeBotaoCapturaImagem)
                        BaseButton(
                          width: 50,
                          onPressed: () {
                            capturarImagem();
                          },
                          text: "Capturar Imagem",
                          backgroundColor: Color(0xFFF0733D),
                          colorFont: Colors.black,
                        )
                    ],
                  )
                ],
              );
            })));
  }
}
