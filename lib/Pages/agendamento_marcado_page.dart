import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AgendamentoMarcadoPage extends StatefulWidget {
  const AgendamentoMarcadoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoMarcadoState();
}

class AgendamentoMarcadoState extends State<AgendamentoMarcadoPage>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Get.offAllNamed("/home");
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Color(0xFF4BE86A),
            body: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                          child: Column(children: [
                        SizedBox(
                          height: alturaTela * 0.4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              "assets/animations/ConfirmAnimation.json",
                              width: larguraTela * 0.6,
                              height: larguraTela * 0.6,
                              repeat: false,
                              frameRate: FrameRate(90),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                width: larguraTela,
                                padding: EdgeInsets.all(35),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                  ),
                                  color: Color(0xFFE8E8E8),
                                ),
                                child: AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(milliseconds: 2000),
                                    curve: Curves.linear,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BaseText(
                                                text: "Sucesso!",
                                                bold: true,
                                                size: 30,
                                                color: Colors.black),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          spacing: 5,
                                          children: [
                                            BaseText(
                                                text:
                                                    "Prontos para te Receber!",
                                                bold: true,
                                                size: 20,
                                                color: Colors.black),
                                            BaseText(
                                                justifyText: true,
                                                text:
                                                    "Mal podemos esperar para te receber aqui no CFC no horário agendado!Já estamos super empolgados e com tudo pronto para te dar toda a atenção que você merece!",
                                                bold: false,
                                                size: 16,
                                                color: Colors.black),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              color: Color(0xFFDDDDDD)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: Column(
                                              spacing: 10,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BaseText(
                                                        text: "Nos vemos em:",
                                                        bold: true,
                                                        size: 18,
                                                        color: Colors.black),
                                                    BaseText(
                                                        text:
                                                            "17/06/2025 ás 14:30",
                                                        bold: false,
                                                        size: 16,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BaseText(
                                                        text: "Endereço:",
                                                        bold: true,
                                                        size: 18,
                                                        color: Colors.black),
                                                    BaseText(
                                                        text:
                                                            "Av. Sapucaia, 1899 - Estação do trem, Sapucaia do Sul - RS",
                                                        bold: false,
                                                        size: 16,
                                                        color: Colors.black),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        BaseButton(
                                            onPressed: () {
                                              Get.offNamed("/agendamentos");
                                            },
                                            heigth: alturaTela * 0.08,
                                            text: "Ver Agendamentos",
                                            colorFont: Colors.black,
                                            backgroundColor: Color(0xFF4BE86A))
                                      ],
                                    ))))
                      ]))));
            })));
  }
}
