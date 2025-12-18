import 'package:cfc_vitoria_app/Dto/Request/Agendamento/alterar_agendamento_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<AgendamentoPage> {
  final AgendamentoRDTO agendamento = Get.arguments as AgendamentoRDTO;

  bool carregando = false;

  Color defineCorPorSituacao(bool container) {
    var situacaoAgendamento = agendamento.situacaoAgendamento;

    switch (situacaoAgendamento) {
      case "Finalizado":
        return container ? Color(0x3315FF00) : const Color(0xFF3BFF3B);
      case "Agendado":
        return container ? Color(0x33FFFF00) : Colors.yellow;
      case "Cancelado":
        return container ? Color(0x33FF0000) : Colors.red;
      default:
        return Colors.white;
    }
  }

  Future<void> _openGoogleMaps() async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=CFC+VITORIA+AUTO+MOTO+ESCOLA');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "Não foi possivel redirecionar para a localização", false);
    }
  }

  Future<void> cancelarAgendamento() async {
    setState(() {
      carregando = true;
    });

    try {
      AlterarAgendamentoDTO alterarAgendamentoDTO =
          AlterarAgendamentoDTO(agendamentoId: agendamento.id);

      await AgendamentoService().excluirAgendamento(alterarAgendamentoDTO);

      var novaSituacaoAgendamento = "Cancelado";

      setState(() {
        carregando = false;
        agendamento.situacaoAgendamento = novaSituacaoAgendamento;
      });

      Get.offNamed("/agendamento_cancelado");
    } catch (e) {
      setState(() {
        carregando = true;
      });

      BaseSnackbar.exibirNotificacao(
          'Erro', "Erro ao tentar alterar situação do agendamento!", false);
    }
  }

  void mostrarDialogConfirmacao(BuildContext context) {
    var mensagemConfirmacao = "Realmente deseja cancelar este agendamento?";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: BaseText(
            text: 'Confirmação',
            size: 18,
            bold: true,
            color: Colors.black,
          ),
          content: BaseText(
            text: mensagemConfirmacao,
            color: Colors.black,
            bold: false,
            size: 14,
          ),
          actions: [
            BaseButton(
              text: "Confirmar",
              colorFont: Colors.black,
              backgroundColor: Color(0xFFF0733D),
              onPressed: () {
                cancelarAgendamento();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 10,
            ),
            BaseButton(
              text: "Cancelar",
              backgroundColor: Colors.red,
              colorFont: Colors.black,
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
        child: carregando
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : SingleChildScrollView(
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
                            BaseText(
                                text: "Situação",
                                size: 12,
                                color: Colors.black38),
                            Container(
                              width: larguraTela * 0.4,
                              decoration: BoxDecoration(
                                  color: defineCorPorSituacao(true),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: defineCorPorSituacao(false),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 20,
                      children: [
                        BaseText(
                            text: "Seriço", size: 12, color: Colors.black38),
                        Container(
                          width: larguraTela,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(70, 226, 226, 226),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.book_outlined,
                                    size: 65,
                                    color: const Color(0xFFF0733D),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BaseText(
                                          text: agendamento.servico.titulo,
                                          size: 20,
                                          color: Colors.black,
                                          bold: true,
                                          maxLines: 2,
                                          overflow: true,
                                        ),
                                        const SizedBox(height: 6),
                                        BaseText(
                                          maxLines: 4,
                                          overflow: true,
                                          text: agendamento.servico.descricao,
                                          size: 12,
                                          color: Colors.black45,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: BaseButton(
                                  heigth: 32,
                                  width: 90,
                                  onPressed: () {
                                    Get.toNamed("servico",
                                        arguments: agendamento.servico);
                                  },
                                  text: "Ver",
                                  backgroundColor: const Color(0xFFF0733D),
                                  colorFont: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ],
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
                            text: "Data/Hora Agendada",
                            size: 12,
                            color: Colors.black38),
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
                        InkWell(
                          onTap: _openGoogleMaps,
                          child: SizedBox(
                            width: larguraTela,
                            height: alturaTela * 0.2,
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/image/localizacao.png",
                            ),
                          ),
                        )
                      ],
                    ),
                    if (agendamento.situacaoAgendamento == "Agendado")
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                              text: "Ações", size: 12, color: Colors.black38),
                          Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                child: BaseButton(
                                  heigth: alturaTela * 0.06,
                                  width: larguraTela * 0.03,
                                  colorFont: Colors.black,
                                  onPressed: () {
                                    mostrarDialogConfirmacao(context);
                                  },
                                  text: "Cancelar",
                                  backgroundColor:
                                      const Color.fromARGB(109, 248, 0, 0),
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
