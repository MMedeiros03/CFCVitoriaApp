import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_button_widget.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  size: 18,
                  color: Colors.black,
                  maxLines: 2,
                  overflow: true,
                  text: "20/10/2025 - 13:30",
                  bold: true,
                ),
                BaseText(
                  size: 11,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black38,
                  text: "faltam 5 dias para a visita.",
                ),
                SizedBox(
                  height: 10,
                ),
                BaseText(
                  size: 13,
                  maxLines: 3,
                  overflow: true,
                  color: Colors.black54,
                  text: "Primeira Habilitação",
                ),
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
