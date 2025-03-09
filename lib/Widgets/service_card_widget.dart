import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_button_widget.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key, required this.description, required this.title});

  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.black12,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 145,
              height: 145,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/image/logo_medeiros.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      size: 16,
                      color: Colors.black,
                      maxLines: 2,
                      overflow: true,
                      text: title,
                      bold: true,
                    ),
                    BaseText(
                      size: 10,
                      maxLines: 3,
                      overflow: true,
                      color: Colors.black45,
                      text: description,
                    ),
                  ],
                ),
                BaseButton(
                  width: 125,
                  heigth: 40,
                  colorFont: Colors.black,
                  backgroundColor: Color(0xFFF0733D),
                  text: "Detalhes",
                  fontSize: 14,
                  onPressed: () {
                    Get.toNamed("/servico");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
