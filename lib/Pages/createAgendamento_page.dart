import 'dart:core';

import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Pages/loading_page.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
import 'package:cfc_vitoria_app/Services/servico_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Dto/Request/Agendamento/agendamento_dto.dart';

class CreateAgendamentoPage extends StatefulWidget {
  const CreateAgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<CreateAgendamentoPage> {
  int _currentStep = 0;
  ServicoRDTO? servicoSelected;
  DateTime? horarioselectedValue;
  List<ServicoRDTO> servicos = [];

  final _formKey = GlobalKey<FormState>();

  List<DateTime> horarios = [];

  bool selecionouData = false;
  DateTime dataSelecionada = DateTime.now();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future _inicializar() async {
    var serviceServico = await ServicoService().getAll();

    setState(() {
      servicos = serviceServico;
    });
  }

  Future _buscaHorariosDisponiveis() async {
    var agendamentoService =
        await AgendamentoService().getHorariosDisponiveis(dataSelecionada);

    setState(() {
      horarios = agendamentoService;
    });
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 40,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepIndicator(0),
              _buildStepIndicator(1),
              _buildStepIndicator(2),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                _stepOne(),
                _stepTwo(),
                _stepTree(),
              ],
            ),
          ),
          BaseButton(
            heigth: 50,
            width: larguraTela * 0.4,
            colorFont: Colors.black,
            backgroundColor: Color(0xFFF0733D),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_currentStep == 2) {
                  criarAgendamento();
                } else {
                  setState(() {
                    _currentStep = _currentStep + 1;
                  });
                }
              }
            },
            text: _currentStep != 2 ? 'Próximo' : 'Finalizar',
          ),
        ],
      ),
    );
  }

  Future criarAgendamento() async {
    try {
      Get.dialog(
        LoadingScreen(),
        barrierDismissible: false,
      );

      DateTime dataCompleta = DateTime(
        dataSelecionada.year,
        dataSelecionada.month,
        dataSelecionada.day,
        horarioselectedValue!.hour,
        horarioselectedValue!.minute,
      );

      await AgendamentoService().createAgendamento(AgendamentoDTO(
          alunoId: 1,
          servicoId: servicoSelected!.id,
          dataHoraAgendamento: dataCompleta,
          observacao: ""));

      Get.back();

      Get.snackbar("Sucesso", "Dados carregados com sucesso!",
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.back();
      Get.snackbar("Erro", "Falha ao carregar os dados!",
          snackPosition: SnackPosition.TOP);
    }
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
            Form(
              key: _formKey,
              child: DropdownButtonFormField<ServicoRDTO>(
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                      color: Color(0xFF970C02),
                      fontFamily: "Libre Baskerville"),
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
                validator: (value) =>
                    value == null ? 'Obrigatório selecionar um serviço.' : null,
                menuMaxHeight: alturaTela * 0.30,
                borderRadius: BorderRadius.circular(12),
                hint: BaseText(
                  text: 'Selecione uma opção',
                  size: 12,
                  color: Colors.black,
                ),
                isExpanded: true,
                value: servicoSelected,
                items: servicos.map((ServicoRDTO item) {
                  return DropdownMenuItem<ServicoRDTO>(
                    value: item,
                    child: BaseText(
                      text: item.titulo,
                      size: 13,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
                onChanged: (ServicoRDTO? newValue) {
                  setState(() {
                    servicoSelected = newValue!;
                  });
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        if (servicoSelected != null)
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
                                  text: servicoSelected?.titulo ?? "",
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: BaseText(
                                  maxLines: 4,
                                  overflow: true,
                                  text: servicoSelected?.descricao ?? "",
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
                                onPressed: () {
                                  Get.toNamed("servico",
                                      arguments: servicoSelected!);
                                },
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

    return Column(
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
            selectedDecoration:
                BoxDecoration(color: Color(0xFFF0733D), shape: BoxShape.circle),
            todayDecoration:
                BoxDecoration(color: Color(0x80F0733D), shape: BoxShape.circle),
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
        SizedBox(height: alturaTela * 0.03),
        if (selecionouData)
          DropdownButtonFormField<DateTime>(
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
            value: horarioselectedValue,
            items: horarios.map((DateTime item) {
              return DropdownMenuItem<DateTime>(
                value: item,
                child: BaseText(
                  text: DateFormat("HH:mm").format(item),
                  color: Colors.black,
                  size: 12,
                ),
              );
            }).toList(),
            onChanged: (DateTime? newValue) {
              setState(() {
                horarioselectedValue = newValue!;
              });
            },
          ),
      ],
    );
  }

  Widget _stepTree() {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return horarioselectedValue == null
        ? SizedBox()
        : Column(
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20,
                children: [
                  BaseText(
                      text: "Seriço Selecionado",
                      size: 12,
                      color: Colors.black38),
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
                                      text: servicoSelected?.titulo ?? "",
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.5,
                                    child: BaseText(
                                      maxLines: 4,
                                      overflow: true,
                                      text: servicoSelected?.descricao ?? "",
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
                                    onPressed: () {
                                      Get.toNamed("servico",
                                          arguments: servicoSelected!);
                                    },
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
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                      text: "Data/Hora Agendada",
                      size: 12,
                      color: Colors.black38),
                  Column(
                    spacing: 15,
                    children: [
                      Row(
                        children: [
                          BaseText(
                            text:
                                "${DateFormat("dd/MM/yyyy").format(dataSelecionada)} - ${DateFormat("HH:mm").format(horarioselectedValue!)} ",
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          BaseText(
                            text: "faltam 5 dias para a visita.",
                            bold: false,
                            size: 15,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
  }

  _diaSelecionado(DateTime diaSelecinado, DateTime diaFocado) {
    setState(() {
      selecionouData = true;
      dataSelecionada = diaSelecinado;
    });

    _buscaHorariosDisponiveis();
  }
}
