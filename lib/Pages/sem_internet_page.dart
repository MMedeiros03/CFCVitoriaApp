import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class SemInternetPage extends StatefulWidget{

  const SemInternetPage({super.key});

  @override
  State<StatefulWidget> createState() => SemInternetPageState();

}

class SemInternetPageState extends State<SemInternetPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("dad"));
  }

}