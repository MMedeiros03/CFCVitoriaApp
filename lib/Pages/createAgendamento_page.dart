import 'package:cfc_vitoria_app/Dto/App/checklist_documentos_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Documento/documento_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
import 'package:cfc_vitoria_app/Services/firebase_service.dart';
import 'package:cfc_vitoria_app/Services/servico_service.dart';
import 'package:cfc_vitoria_app/Utils/enums.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:table_calendar/table_calendar.dart';

import '../Dto/Request/Agendamento/agendamento_dto.dart';
import '../Widgets/doc_card_widget.dart';

class CreateAgendamentoPage extends StatefulWidget {
  const CreateAgendamentoPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentoPageState();
}

class AgendamentoPageState extends State<CreateAgendamentoPage> {
  final ServicoRDTO? servico = Get.arguments as ServicoRDTO?;

  bool criandoAgendamento = false;
  List<ChecklistDocumentoDto> checkListDocumentos = [];
  List<DocumentoDTO> listaDocumentos = [];
  int _currentStep = 0;
  ServicoRDTO? servicoSelected;
  DateTime? horarioselectedValue;
  List<ServicoRDTO> servicos = [];
  bool carregando = true;
  bool carregandoHorarios = true;
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
      carregando = false;
      servicos = serviceServico;
    });

    if (servico != null) {
      var servicoSelecionadoDetalhes =
          serviceServico.where((x) => x.id == servico?.id).firstOrNull;

      if (servicoSelecionadoDetalhes != null) {
        setState(() {
          servicoSelected = servicoSelecionadoDetalhes;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: criandoAgendamento
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 40,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepIndicator(0),
                    _buildStepIndicator(1),
                    _buildStepIndicator(2),
                    _buildStepIndicator(3),
                  ],
                ),
                Expanded(
                  child: IndexedStack(
                    index: _currentStep,
                    children: [
                      _stepOne(),
                      _stepTwo(),
                      _stepTree(),
                      _stepFor(),
                    ],
                  ),
                ),
                BaseButton(
                  heigth: 50,
                  width: larguraTela * 0.4,
                  colorFont: Colors.black,
                  backgroundColor: Color(0xFFF0733D),
                  onPressed: () {
                    _validacoesPorStep();
                  },
                  text: _currentStep != 3 ? 'Próximo' : 'Finalizar',
                ),
              ],
            ),
    );
  }

  Future criarAgendamento() async {
    try {
      setState(() {
        criandoAgendamento = true;
      });

      DateTime dataCompleta = DateTime(
        dataSelecionada.year,
        dataSelecionada.month,
        dataSelecionada.day,
        horarioselectedValue!.hour,
        horarioselectedValue!.minute,
      );

      var alunoId = await StorageService.getAlunoId();

      if (alunoId == null) {
        BaseSnackbar.exibirNotificacao(
            "Erro", "Não foi possivel identificar o aluno", false);

        return;
      }

      for (var documento in checkListDocumentos) {
        var documentoRenomeado = await Utils.renomearArquivo(
            documento.documento!, documento.tipoDocumento.name);

        var pathArquivoFirebase = await FirebaseService().uploadImagem(
          alunoId: alunoId,
          imagem: documentoRenomeado,
        );

        listaDocumentos.add(DocumentoDTO(
            tipoDocumento: documento.tipoDocumento.index,
            nomeArquivo: p.basename(documentoRenomeado.path),
            pathDocumento: pathArquivoFirebase!));
      }

      await AgendamentoService().createAgendamento(AgendamentoDTO(
          alunoId: alunoId,
          servicoId: servicoSelected!.id,
          dataHoraAgendamento: dataCompleta,
          documentosAluno: listaDocumentos,
          observacao: ""));

      setState(() {
        criandoAgendamento = false;
      });

      BaseSnackbar.exibirNotificacao(
          "Sucesso", "Agendamento criado com sucesso!", true);

      Get.offNamed("/agendamentos");
    } catch (e) {
      setState(() {
        criandoAgendamento = false;
      });

      BaseSnackbar.exibirNotificacao(
          "Erro", "Falha ao criar agendamento!", false);
    }
  }

  Widget _buildStepIndicator(int step) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _currentStep = step;
          });
        }
      },
      child: Container(
        width: 70,
        height: 20,
        decoration: BoxDecoration(
            color: Color(0xFFF0733D),
            shape: _currentStep == step ? BoxShape.rectangle : BoxShape.circle,
            borderRadius:
                _currentStep == step ? BorderRadius.circular(12) : null),
      ),
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
                  text: carregando ? "Buscando..." : "Selecione uma opção",
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
          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: DateTime.utc(DateTime.now().year + 1, 1, 31),
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
              text: carregandoHorarios ? "Buscando..." : 'Selecione uma opção',
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
    final documentoCPFFrente = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.cpfFrente);
    final documentoCPFVerso = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.cpfVerso);
    final documentoCNHFrente = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.cnhFrente);
    final documentoCNHVerso = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.cnhVerso);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text:
              "Por favor, envie as imagens dos documentos solicitados abaixo, garantindo que estejam legíveis e completos.",
          size: 15,
          color: Colors.black87,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                DocCard(
                  exibeBotaoCapturaImagem: documentoCPFFrente == null,
                  capturarImagem: () {
                    _redirect(TipoDocumento.cpfFrente);
                  },
                  tituloDocumento: "CPF (Frente)",
                ),
                DocCard(
                  exibeBotaoCapturaImagem: documentoCPFVerso == null,
                  capturarImagem: () {
                    _redirect(TipoDocumento.cpfVerso);
                  },
                  tituloDocumento: "CPF (Verso)",
                ),
                DocCard(
                  exibeBotaoCapturaImagem: documentoCNHFrente == null,
                  capturarImagem: () {
                    _redirect(TipoDocumento.cnhFrente);
                  },
                  tituloDocumento: "CNH (Frente)",
                ),
                DocCard(
                  exibeBotaoCapturaImagem: documentoCNHVerso == null,
                  capturarImagem: () {
                    _redirect(TipoDocumento.cnhVerso);
                  },
                  tituloDocumento: "CNH (Verso)",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _stepFor() {
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
                            text: _calculaDiasParaAgendamento(),
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

  void _validacoesPorStep() {
    switch (_currentStep) {
      case 0:
        validaStepOne();
        return;
      case 1:
        validaStepTwo();
        return;
      case 2:
        validaStepTree();
        return;
      case 3:
        criarAgendamento();
        return;
    }
  }

  void validaStepOne() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentStep = _currentStep + 1;
      });
    }

    return;
  }

  void validaStepTwo() {
    if (horarioselectedValue == null) {
      BaseSnackbar.exibirNotificacao("Erro",
          "Obrigatório selecionar uma data e horário para prosseguir!", false);
    } else {
      setState(() {
        _currentStep = _currentStep + 1;
      });
    }
  }

  void validaStepTree() {
    // validar os documentos
    if (checkListDocumentos.length < 4) {
      BaseSnackbar.exibirNotificacao(
          "Erro",
          "Obrigatório capturar uma imagem de todos os documentos selecionados",
          false);
    } else {
      setState(() {
        _currentStep = _currentStep + 1;
      });
    }
  }

  Future _buscaHorariosDisponiveis() async {
    setState(() {
      horarios = [];
      horarioselectedValue = null;
      carregandoHorarios = true;
    });

    var agendamentoService =
        await AgendamentoService().getHorariosDisponiveis(dataSelecionada);

    setState(() {
      horarios = agendamentoService;
      carregandoHorarios = false;
    });
  }

  void _redirect(TipoDocumento tipoDocumento) async {
    final image = await Get.toNamed("captura-imagem");

    if (image != null) {
      checkListDocumentos.add(ChecklistDocumentoDto(
          tipoDocumento: tipoDocumento, documento: image));

      setState(() {});
    }
  }

  String _calculaDiasParaAgendamento() {
    final hoje = DateTime.now();
    final diasDiferenca = dataSelecionada.difference(hoje).inDays;
    return diasDiferenca > 0
        ? "Faltam $diasDiferenca dias para a visita!"
        : "Sua visita é hoje!";
  }

  _diaSelecionado(DateTime diaSelecinado, DateTime diaFocado) {
    setState(() {
      selecionouData = true;
      dataSelecionada = diaSelecinado;
    });

    _buscaHorariosDisponiveis();
  }
}
