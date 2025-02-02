import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<AgendamentoPage> {
  List<String> horarios = [
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
    "09:00",
  ];

  bool selecionouData = false;
  DateTime dataSelecionada = DateTime.now();
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Selecione uma data para visualizar os horários disponiveis",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TableCalendar(
              calendarStyle: CalendarStyle(
                  cellMargin: const EdgeInsets.all(0),
                  defaultTextStyle: TextStyle(fontSize: 15),
                  selectedDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                  ),
                  todayDecoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle
                  ),
              ),
              selectedDayPredicate: (day) => isSameDay(day, dataSelecionada),
              calendarFormat: CalendarFormat.month,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              focusedDay: dataSelecionada,
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2026, 1, 31),
              rowHeight: alturaTela * 0.040,
              onDaySelected: _diaSelecionado,
            ),
            SizedBox(height: alturaTela * 0.03),
            if (selecionouData)
              Text(
                "Horários disponíveis para o dia ${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (selecionouData) SizedBox(height: alturaTela * 0.02),
            if (selecionouData)
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: horarios.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.black54 : Color(0xFFD9D9D9),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          horarios[index],
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (selecionouData) SizedBox(height: alturaTela * 0.01),
            if (selecionouData)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _diaSelecionado(DateTime diaSelecinado, DateTime diaFocado) {
    setState(() {
      selecionouData = true;
      dataSelecionada = diaSelecinado;
    });
  }
}
