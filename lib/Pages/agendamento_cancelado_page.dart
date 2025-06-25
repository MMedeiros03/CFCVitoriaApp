import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AgendamentoCanceladoPage extends StatefulWidget {
  const AgendamentoCanceladoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoCanceladoState();
}

class AgendamentoCanceladoState extends State<AgendamentoCanceladoPage>
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
            backgroundColor: Color(0xFFFF4F4F),
            body: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                          child: Column(children: [
                        SizedBox(
                          height: alturaTela * 0.35,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              "assets/animations/CancelAnimation.json",
                              width: larguraTela * 2.5,
                              height: larguraTela * 0.55,
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
                                                text: "Cancelado!",
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
                                          spacing: 2,
                                          children: [
                                            BaseText(
                                                text:
                                                    "Seu agendamento foi cancelado com sucesso!",
                                                bold: true,
                                                size: 20,
                                                color: Colors.black),
                                            BaseText(
                                                text:
                                                    "No momento, não há nenhuma ação pendente.",
                                                bold: false,
                                                size: 16,
                                                color: Colors.black),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            BaseText(
                                                text: "Conte com a gente!",
                                                bold: true,
                                                size: 20,
                                                color: Colors.black),
                                            BaseText(
                                                justifyText: true,
                                                text:
                                                    "Se precisar, você pode reagendar para outro horário, será um prazer lhe atender! Estamos sempre à disposição para o que precisar. Pode contar com a gente para oferecer todo o suporte e cuidado que você merece.",
                                                bold: false,
                                                size: 16,
                                                color: Colors.black),
                                          ],
                                        ),
                                        BaseButton(
                                          onPressed: () {
                                            Get.offNamed("/create-agendamento");
                                          },
                                          fontSize: 15,
                                          heigth: alturaTela * 0.08,
                                          text: "Agendar Novamente",
                                          colorFont: Colors.black,
                                          backgroundColor: Color(0xFF4BE86A),
                                        ),
                                        BaseButton(
                                          onPressed: () {
                                            Get.offNamed("/home");
                                          },
                                          fontSize: 15,
                                          heigth: alturaTela * 0.08,
                                          text: "Voltar",
                                          colorFont: Colors.black,
                                          backgroundColor: Color(0xFFFF4F4F),
                                        )
                                      ],
                                    ))))
                      ]))));
            })));
  }
}
