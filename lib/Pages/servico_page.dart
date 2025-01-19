import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class ServicoPage extends StatefulWidget{

  const ServicoPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicoPageState();

}

class ServicoPageState extends State<ServicoPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}