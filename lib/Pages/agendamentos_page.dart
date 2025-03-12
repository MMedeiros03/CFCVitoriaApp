import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
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
  List<AgendamentoRDTO> agendamentos = [];
  List<DateTime> horarios = [];

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future _inicializar() async {
    var service = AgendamentoService();

    var agendamentosApi = await service.getAll();

    var horariosApi = await service.getHorariosDisponiveis(DateTime.now());

    setState(() {
      agendamentos = agendamentosApi;
      horarios = horariosApi;
    });
  }

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
            text: " ${agendamentos.length} Agendamentos Encontrados",
            size: 13,
            color: Colors.black,
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                AgendamentoRDTO agendamento = agendamentos[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    width: larguraTela,
                    height: alturaTela * 0.16,
                    child: ScheduleCard(
                      id: agendamento.id,
                      dataAgendamento: agendamento.dataHoraAgendado,
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
