import 'dart:core';

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
  int _currentStep = 0;
  String? selectedValue;
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

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
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepIndicator(0),
              _buildStepIndicator(1),
              _buildStepIndicator(2),
            ],
          ),
          IndexedStack(
            index: _currentStep,
            children: [
              _stepOne(),
              _stepTwo(),
              _stepTree(),
            ],
          ),
          BaseButton(
            heigth: 50,
            width: larguraTela * 0.4,
            colorFont: Colors.black,
            backgroundColor: Color(0xFFF0733D),
            onPressed: () {
              setState(() {
                _currentStep = _currentStep + 1;
              });
            },
            text: _currentStep != 3 ? 'Próximo' : 'Finalizar',
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step) {
    return Container(
      width: 70,
      height: 20,
      decoration: BoxDecoration(
          color: Color(0xFFF0733D),
          shape: _currentStep == step ? BoxShape.rectangle : BoxShape.circle,
          borderRadius:
              _currentStep == step ? BorderRadius.circular(12) : null),
    );
  }

  Widget _stepOne() {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            BaseText(
                text: "Selecione o serviço desejado",
                size: 14,
                color: Colors.black54),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
                labelStyle: TextStyle(
                    color: Colors.black38, fontFamily: "Libre Baskerville"),
                prefixIcon: Icon(Icons.book, size: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF0733D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF0733D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
                ),
              ),
              menuMaxHeight: alturaTela * 0.30,
              borderRadius: BorderRadius.circular(12),
              hint: BaseText(
                text: 'Selecione uma opção',
                size: 12,
                color: Colors.black,
              ),
              isExpanded: true,
              value: selectedValue,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        if (selectedValue != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              BaseText(
                  text: "Seriço Selecionado", size: 12, color: Colors.black38),
              Container(
                height: alturaTela * 0.2,
                width: larguraTela,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 226, 226, 226),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 65,
                            color: Color(0xFFF0733D),
                          ),
                          Column(
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: BaseText(
                                  text: "Primeira Habilitação",
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: BaseText(
                                  maxLines: 4,
                                  overflow: true,
                                  text:
                                      "fyacdafdaydadaydafdadawydadaydfadywt dadad adawdawdawdaw dadawdadadawd adawdad awd",
                                  size: 12,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BaseButton(
                                heigth: 30,
                                width: constraints.maxWidth * 0.25,
                                onPressed: () {},
                                text: "Ver",
                                backgroundColor: Color(0xFFF0733D),
                                colorFont: Colors.black,
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          )
      ],
    );
  }

  Widget _stepTwo() {
    final alturaTela = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseText(
            text: "Selecione uma data para visualizar os horários disponiveis",
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
                        backgroundColor:
                            isSelected ? Color(0xFFF0733D) : Color(0x4DF0733D),
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
    );
  }

  Widget _stepTree() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(""),
    );
  }

  _diaSelecionado(DateTime diaSelecinado, DateTime diaFocado) {
    setState(() {
      selecionouData = true;
      dataSelecionada = diaSelecinado;
    });
  }
}
