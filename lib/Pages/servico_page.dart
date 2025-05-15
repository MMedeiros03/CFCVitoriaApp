import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/ValorServico/valor_servico_rdto.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../Widgets/base_page_widget.dart';

class ServicoPage extends StatefulWidget {
  const ServicoPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicoPageState();
}

class ServicoPageState extends State<ServicoPage>
    with SingleTickerProviderStateMixin {
  final ServicoRDTO servico = Get.arguments as ServicoRDTO;
  late AnimationController _controller;

  Future _validarERedirecionar(path) async {
    var tokenValido = await Utils.validaToken();

    if (!tokenValido) {
      Get.toNamed("/login",
          arguments:
              "Você precisa fazer o login para criar um novo agendamento");
    } else {
      Get.offNamed(path, arguments: servico);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem
            SizedBox(
              height: larguraTela * 0.45,
              child: Lottie.asset(
                "assets/animations/LearnAnimation.json",
                fit: BoxFit.cover,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),

            SizedBox(height: 20),

            // Título
            BaseText(
              text: servico.titulo,
              size: 15,
              bold: true,
              alignText: true,
              color: Colors.black,
            ),
            SizedBox(height: 10),

            // Descrição
            BaseText(
              text: servico.descricao,
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
                onPressed: () {
                  _validarERedirecionar("/create-agendamento");
                },
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
                                    text:
                                        "Duração : ${servico.anosValidade} horas",
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
                                    text:
                                        "Validade : ${servico.anosValidade} anos",
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
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              spacing: 15,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BaseText(
                                        text: "Valores",
                                        size: 18,
                                        color: Colors.black)
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: servico.valorServicos.length,
                                  itemBuilder: (context, index) {
                                    ValorServicoRDTO valorServico =
                                        servico.valorServicos[index];

                                    return LayoutBuilder(
                                        builder: (context, constraints) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: BaseText(
                                              maxLines: 2,
                                              overflow: true,
                                              text: valorServico.descricao,
                                              size: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.paid_outlined,
                                                  color: Color(0xFFF0733D)),
                                              SizedBox(
                                                  width: constraints.maxWidth *
                                                      0.85,
                                                  child: BaseText(
                                                      bold: false,
                                                      text:
                                                          " R\$ ${valorServico.valor}",
                                                      size: 18,
                                                      color: Colors.black45)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ))),
                  Container(
                    width: larguraTela * 0.7,
                    // Defina uma altura máxima ou fixa
                    constraints: BoxConstraints(
                      maxHeight:
                          300, // ajuste esse valor conforme o layout desejado
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.black12,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BaseText(
                                text: "Pré Requisitos",
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            ...[
                              "Ser maior de 21 anos;",
                              "Possuir CNH (Carteira Nacional de Habilitação) categoria B, C, D ou E;",
                              "Não estar cumprindo pena de suspensão do direito de dirigir.",
                              "Não ter cometido mais de uma infração gravíssima nos últimos 12 meses;",
                              "Não ter processo de cassação da CNH em andamento;",
                            ].map((texto) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.circle, size: 5),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: BaseText(
                                        text: texto,
                                        size: 12,
                                        color: Colors.black,
                                        bold: false,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
