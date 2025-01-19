import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class MeusDadosPage extends StatefulWidget{

  const MeusDadosPage({super.key});

  @override
  State<StatefulWidget> createState() => MeusDadosPageState();

}

class MeusDadosPageState extends State<MeusDadosPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}