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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.black12,
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: Color(0xFFF0733D),
            size: 50,
          ),
          SizedBox(width: 12),
          Expanded(
            // garante que textos se ajustem
            child: Column(
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
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: defineCorPorSituacao(true),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle,
                          size: 12, color: defineCorPorSituacao(false)),
                      SizedBox(width: 4),
                      BaseText(
                        bold: true,
                        text: agendamento.situacaoAgendamento,
                        size: 12,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
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
        ],
      ),
    );
  }
}
