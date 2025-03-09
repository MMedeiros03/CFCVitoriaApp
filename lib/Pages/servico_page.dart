import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class ServicoPage extends StatefulWidget {
  const ServicoPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicoPageState();
}

class ServicoPageState extends State<ServicoPage> {
  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/image/logo_medeiros.jpg",
                width: larguraTela,
                height: alturaTela * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Título
            BaseText(
              text: "MOVIMENTAÇÃO DE CARGAS PERIGOSAS - MOPP",
              size: 15,
              bold: true,
              alignText: true,
              color: Colors.black,
            ),
            SizedBox(height: 10),

            // Descrição
            BaseText(
              text:
                  "O curso de Transporte de Cargas Indivisíveis capacita motoristas para transportar cargas de grandes dimensões e pesos que não podem ser divididas, como máquinas industriais, transformadores e estruturas metálicas. O curso inclui conhecimentos sobre legislação, segurança e técnicas específicas e movimentação de cargas.",
              alignText: false,
              justifyText: true,
              size: 13,
              bold: false,
              color: Colors.black87,
            ),
            SizedBox(height: 15),

            // Botão
            Align(
              alignment: Alignment.centerRight,
              child: BaseButton(
                width: 140,
                heigth: 45,
                fontSize: 13,
                backgroundColor: Color(0xFFF0733D),
                colorFont: Colors.black,
                onPressed: () {},
                text: "Tenho interesse",
              ),
            ),
            SizedBox(height: 20),

            // Carousel
            CarouselSlider(
                options: CarouselOptions(
                  height: alturaTela * 0.4,
                  enableInfiniteScroll: false,
                  initialPage: 1,
                  autoPlay: false,
                ),
                items: [
                  Container(
                      width: larguraTela * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.schedule_outlined,
                                  color: Color(0xFFF0733D),
                                  size: 40,
                                ),
                                BaseText(
                                    text: "Duração : ",
                                    size: 16,
                                    color: Colors.black)
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xFFF0733D),
                                  size: 40,
                                ),
                                BaseText(
                                    text: "Validade : ",
                                    size: 16,
                                    color: Colors.black)
                              ],
                            ),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.task_alt_outlined,
                                    color: Color(0xFFF0733D),
                                    size: 40,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.8,
                                      child: BaseText(
                                          maxLines: 2,
                                          text: "Reconhecido e homologado",
                                          size: 16,
                                          color: Colors.black))
                                ],
                              );
                            }),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    color: Color(0xFFF0733D),
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.8,
                                    child: BaseText(
                                        maxLines: 2,
                                        text: "Certificado integrado ao DETRAN",
                                        size: 16,
                                        color: Colors.black),
                                  )
                                ],
                              );
                            }),
                          ],
                        ),
                      )),
                  Container(
                      width: larguraTela * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [],
                      )),
                  Container(
                      width: larguraTela * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Column(
                          spacing: 20,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BaseText(
                                    text: "Pré Requisitos",
                                    size: 18,
                                    color: Colors.black)
                              ],
                            ),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      child: BaseText(
                                          bold: false,
                                          text: "Ser maior de 21 anos;",
                                          size: 12,
                                          color: Colors.black)),
                                ],
                              );
                            }),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      child: BaseText(
                                          bold: false,
                                          maxLines: 4,
                                          text:
                                              "Possuir CNH (Carteira Nacional de Habilitação) categoria B, C, D ou E;",
                                          size: 12,
                                          color: Colors.black)),
                                ],
                              );
                            }),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      child: BaseText(
                                          bold: false,
                                          maxLines: 3,
                                          text:
                                              "Não estar cumprindo pena de suspensão do direito de dirigir.",
                                          size: 12,
                                          color: Colors.black)),
                                ],
                              );
                            }),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      child: BaseText(
                                          bold: false,
                                          maxLines: 3,
                                          text:
                                              "Não ter cometido mais de uma infração gravíssima nos últimos 12 meses;",
                                          size: 12,
                                          color: Colors.black)),
                                ],
                              );
                            }),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      child: BaseText(
                                          bold: false,
                                          text:
                                              "Não ter processo de cassação da CNH em andamento;",
                                          size: 12,
                                          color: Colors.black)),
                                ],
                              );
                            })
                          ],
                        ),
                      )),
                ]),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
