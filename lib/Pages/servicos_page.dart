import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:cfc_vitoria_app/Widgets/service_card_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicosPageState();
}

class ServicosPageState extends State<ServicosPage> {
  List<String> items = List.generate(16, (index) => (index + 1).toString());

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
            text: " ${items.length} Serviços Encontrados",
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
                    height: alturaTela * 0.20,
                    child: ServiceCard(
                      title: "Lorem Ipsumis simply",
                      description: "Lorem Ipsumis ",
                    ),
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
