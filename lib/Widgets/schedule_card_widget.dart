import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'base_button_widget.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.id,
    required this.dataAgendamento,
  });

  final DateTime dataAgendamento;
  final int id;

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
                  text:
                      DateFormat("dd/MM/yyyy - HH:mm").format(dataAgendamento),
                  bold: true,
                ),
                BaseText(
                  size: 11,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black38,
                  text: "faltam 5 dias para a visita.",
                ),
                BaseText(
                  size: 13,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black54,
                  text: "Primeira Habilitação",
                ),
                Container(
                  width: larguraTela * 0.4,
                  height: alturaTela * 0.035,
                  decoration: BoxDecoration(
                      color: const Color(0x4700EF24),
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
                          color: const Color.fromARGB(255, 0, 207, 7),
                        ),
                        BaseText(
                            bold: true,
                            text: "Confirmado",
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
                  Get.toNamed("/agendamento");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
