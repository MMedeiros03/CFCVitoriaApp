import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<AgendamentoPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(child: Text("detalhes do agendamento"));
  }
}
