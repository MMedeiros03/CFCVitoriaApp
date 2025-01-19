import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:flutter/widgets.dart';

class AgendamentoPage extends StatefulWidget{

  const AgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();

}

class AgendamentoPageState extends State<AgendamentoPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}