import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class SobreNosPage extends StatefulWidget{

  const SobreNosPage({super.key});

  @override
  State<StatefulWidget> createState() => SobreNosPageState();

}

class SobreNosPageState extends State<SobreNosPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}