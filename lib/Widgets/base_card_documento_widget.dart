import 'package:cfc_vitoria_app/Utils/enums.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

class BaseCardDocumento extends StatelessWidget {
  const BaseCardDocumento({
    super.key,
    required this.tipoDocumento,
    required this.nomeArquivo,
  });

  final String nomeArquivo;
  final TipoDocumento tipoDocumento;

  String defineTituloPorTipoDocumento(TipoDocumento tipoDocumento) {
    switch (tipoDocumento) {
      case TipoDocumento.cnhFrente:
        return "CNH - Frente";
      case TipoDocumento.cpfFrente:
        return "CPF - Frente";
      case TipoDocumento.cpfVerso:
        return "CPF - Verso";
      case TipoDocumento.cnhVerso:
        return "CNH - VERSO";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black12,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(6, 18, 6, 18),
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
                        Icons.task_outlined,
                        color: Color(0xFFF0733D),
                        size: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.8,
                            child: BaseText(
                                text: nomeArquivo,
                                overflow: true,
                                maxLines: 1,
                                size: 16,
                                color: Colors.black),
                          ),
                          Container(
                            width: constraints.maxWidth * 0.5,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: BaseText(
                                maxLines: 2,
                                overflow: true,
                                text:
                                    defineTituloPorTipoDocumento(tipoDocumento),
                                size: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            })));
  }
}
