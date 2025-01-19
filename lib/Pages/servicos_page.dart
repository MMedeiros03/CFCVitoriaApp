import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class ServicosPage extends StatefulWidget{

  const ServicosPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicosPageState();

}

class ServicosPageState extends State<ServicosPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}