import 'package:cfc_vitoria_app/Dto/Response/Campanha/campanha_rdto.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/base_page_widget.dart';

class CampanhaPage extends StatefulWidget {
  const CampanhaPage({super.key});

  @override
  State<StatefulWidget> createState() => CampanhaPageState();
}

class CampanhaPageState extends State<CampanhaPage> {
  final CampanhaRDTO campanha = Get.arguments as CampanhaRDTO;

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                BaseText(
                  color: Colors.black,
                  text: "Titulo",
                  size: 28,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Color(0xFFF0733D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(spacing: 20, children: [
              BaseText(
                  justifyText: true,
                  bold: false,
                  text: campanha.titulo,
                  size: 16,
                  color: Colors.black87)
            ])
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                BaseText(
                  color: Colors.black,
                  text: "Descrição",
                  size: 28,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Color(0xFFF0733D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(spacing: 20, children: [
              BaseText(
                  justifyText: true,
                  bold: false,
                  text: campanha.descricao,
                  size: 15,
                  color: Colors.black45)
            ])
          ])
        ],
      ),
    ));
  }
}
