import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentosPage extends StatefulWidget{

  const AgendamentosPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentosPageState();

}

class AgendamentosPageState extends State<AgendamentosPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}