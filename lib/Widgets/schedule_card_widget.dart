import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'base_button_widget.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.agendamento,
  });

  final AgendamentoRDTO agendamento;

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

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.black12,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 8, left: 0, top: 16, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFF0733D),
              size: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  size: 17,
                  color: Colors.black,
                  maxLines: 2,
                  overflow: true,
                  text: DateFormat("dd/MM/yyyy - HH:mm")
                      .format(agendamento.dataHoraAgendado),
                  bold: true,
                ),
                BaseText(
                  size: 11,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black38,
                  text: agendamento.contagemDias,
                ),
                BaseText(
                  size: 13,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black54,
                  text: agendamento.servico.titulo,
                ),
                Container(
                  width: larguraTela * 0.4,
                  height: alturaTela * 0.035,
                  decoration: BoxDecoration(
                      color: defineCorPorSituacao(true),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: defineCorPorSituacao(false),
                        ),
                        BaseText(
                            bold: true,
                            text: agendamento.situacaoAgendamento,
                            size: 12,
                            color: Colors.black)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BaseButton(
                width: 125,
                heigth: 40,
                colorFont: Colors.black,
                backgroundColor: Color(0xFFF0733D),
                text: "Detalhes",
                fontSize: 14,
                onPressed: () {
                  Get.toNamed("/agendamento", arguments: agendamento);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
