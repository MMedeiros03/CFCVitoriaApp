import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

import 'base_button_widget.dart';

class DocCard extends StatelessWidget {
  const DocCard({
    super.key,
    required this.capturarImagem,
    required this.tituloDocumento,
    required this.carregando,
    required this.exibeBotaoCapturaImagem,
  });

  final String tituloDocumento;
  final Function capturarImagem;
  final bool exibeBotaoCapturaImagem;
  final bool carregando;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: Color(0xFFF0733D),
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: tituloDocumento,
                        overflow: true,
                        size: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: constraints.maxWidth * 0.75,
                        child: const BaseText(
                          maxLines: 2,
                          overflow: true,
                          text:
                              "Capture uma nova imagem do documento solicitado acima",
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
                  if (carregando)
                    const SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  else if (exibeBotaoCapturaImagem)
                    BaseButton(
                      width: 150,
                      onPressed: () => capturarImagem(),
                      text: "Capturar Imagem",
                      backgroundColor: const Color(0xFFF0733D),
                      colorFont: Colors.black,
                    )
                  else
                    const Icon(
                      Icons.check_circle_outline,
                      size: 65,
                      color: Colors.green,
                    ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
