import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<AgendamentoPage> {
  final AgendamentoRDTO agendamento = Get.arguments as AgendamentoRDTO;

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
        child: SingleChildScrollView(
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: "Situação", size: 12, color: Colors.black38),
                  Container(
                    width: larguraTela * 0.4,
                    decoration: BoxDecoration(
                        color: const Color(0x4700EF24),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.circle,
                            color: const Color.fromARGB(255, 0, 207, 7),
                          ),
                          BaseText(
                              bold: true,
                              text: agendamento.situacaoAgendamento,
                              size: 13,
                              color: Colors.black)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(text: "Seriço", size: 12, color: Colors.black38),
              Container(
                height: alturaTela * 0.2,
                width: larguraTela,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 226, 226, 226),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 65,
                            color: Color(0xFFF0733D),
                          ),
                          Column(
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: BaseText(
                                  text: agendamento.servico.titulo,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: BaseText(
                                  maxLines: 4,
                                  overflow: true,
                                  text: agendamento.servico.descricao,
                                  size: 12,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BaseButton(
                                heigth: 30,
                                width: constraints.maxWidth * 0.25,
                                onPressed: () {
                                  Get.toNamed("servico",
                                      arguments: agendamento.servico);
                                },
                                text: "Ver",
                                backgroundColor: Color(0xFFF0733D),
                                colorFont: Colors.black,
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: "Data/Hora Agendada", size: 12, color: Colors.black38),
              Column(
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: DateFormat("dd/MM/yyyy")
                            .format(agendamento.dataHoraAgendado),
                        size: 25,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BaseText(
                        text: agendamento.contagemDias,
                        bold: false,
                        size: 15,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: "Local de Atendimento",
                  size: 12,
                  color: Colors.black38),
              SizedBox(
                width: larguraTela,
                child: Image.asset(
                  "assets/image/logo_cfc.jpg",
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(text: "Ações", size: 12, color: Colors.black38),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: BaseButton(
                      heigth: alturaTela * 0.06,
                      width: larguraTela * 0.03,
                      colorFont: Colors.black,
                      onPressed: () {},
                      text: "Confirmar",
                      backgroundColor: const Color.fromARGB(110, 0, 248, 37),
                    ),
                  ),
                  Expanded(
                    child: BaseButton(
                      heigth: alturaTela * 0.06,
                      width: larguraTela * 0.03,
                      colorFont: Colors.black,
                      onPressed: () {},
                      text: "Cancelar",
                      backgroundColor: const Color.fromARGB(109, 248, 0, 0),
                    ),
                  ),
                  Expanded(
                    child: BaseButton(
                      heigth: alturaTela * 0.06,
                      width: larguraTela * 0.03,
                      colorFont: Colors.black,
                      onPressed: () {},
                      text: "Remarcar",
                      backgroundColor: const Color.fromARGB(109, 244, 248, 0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
