import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateAgendamentoPage extends StatefulWidget {
  const CreateAgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<CreateAgendamentoPage> {
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
            BaseText(
              text:
                  "Selecione uma data para visualizar os horários disponiveis",
              alignText: true,
              size: 16,
              bold: true,
              color: Colors.black,
            ),
            TableCalendar(
              calendarStyle: CalendarStyle(
                cellMargin: const EdgeInsets.all(0),
                weekendTextStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: "Libre Baskerville",
                    color: Colors.black26),
                defaultTextStyle:
                    TextStyle(fontSize: 15, fontFamily: "Libre Baskerville"),
                selectedDecoration: BoxDecoration(
                    color: Color(0xFFF0733D), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: Color(0x80F0733D), shape: BoxShape.circle),
              ),
              selectedDayPredicate: (day) => isSameDay(day, dataSelecionada),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: "Libre Baskerville",
                    fontWeight: FontWeight.bold),
              ),
              focusedDay: dataSelecionada,
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2026, 1, 31),
              rowHeight: alturaTela * 0.040,
              onDaySelected: _diaSelecionado,
            ),
            SizedBox(height: alturaTela * 0.03),
            if (selecionouData)
              BaseText(
                text:
                    "Horários disponíveis para o dia ${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}",
                size: 15,
                bold: true,
                color: Colors.black,
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
                          backgroundColor: isSelected
                              ? Color(0xFFF0733D)
                              : Color(0x4DF0733D),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: BaseText(
                          text: horarios[index],
                          color: Colors.white,
                          size: 13,
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (selecionouData) SizedBox(height: alturaTela * 0.01),
            if (selecionouData)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BaseButton(
                      onPressed: () {},
                      colorFont: Colors.black,
                      heigth: 40,
                      width: 120,
                      text: "Próximo",
                      backgroundColor: Color(0xFFF0733D)),
                ],
              )
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
