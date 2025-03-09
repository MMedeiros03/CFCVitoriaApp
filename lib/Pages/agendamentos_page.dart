import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:cfc_vitoria_app/Widgets/schedule_card_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentosPage extends StatefulWidget {
  const AgendamentosPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentosPageState();
}

class AgendamentosPageState extends State<AgendamentosPage> {
  List<int> items = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          BaseText(
            text: " ${items.length} Agendamentos Encontrados",
            size: 13,
            color: Colors.black,
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    width: larguraTela,
                    height: alturaTela * 0.16,
                    child: ScheduleCard(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
