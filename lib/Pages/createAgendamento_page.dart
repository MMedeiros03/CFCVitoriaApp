import 'package:cfc_vitoria_app/Dto/App/checklist_documentos_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Documento/documento_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Services/supabase_storage.dart';
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
  Set<TipoDocumento> documentosCarregando = {};
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

    await validarDocumentosAluno();

    if (!mounted) return;

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

  Future validarDocumentosAluno() async {
    var documentosAluno = await StorageService.getListaDocumentosAluno();

    for (var documento in documentosAluno) {
      TipoDocumento tipoDocumentoAluno =
          TipoDocumento.values[documento.tipoDocumento];

      checkListDocumentos
          .add(ChecklistDocumentoDto(tipoDocumento: tipoDocumentoAluno));
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          mostrarDialogConfirmacao(context);
        },
        child: BasePage(
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
        ));
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

      await AgendamentoService().createAgendamento(AgendamentoDTO(
          alunoId: alunoId,
          servicoId: servicoSelected!.id,
          dataHoraAgendamento: dataCompleta,
          observacao: ""));

      setState(() {
        criandoAgendamento = false;
      });

      Get.offNamed("/agendamento_marcado", arguments: dataCompleta);
    } catch (e) {
      setState(() {
        criandoAgendamento = false;
      });

      BaseSnackbar.exibirNotificacao(
          "Erro", "Falha ao criar agendamento!", false);
    }
  }

  Widget _buildStepIndicator(int step) {
    bool isSelected = _currentStep == step;

    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _currentStep = step;
          });
        }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 5),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSelected ? 70 : 20,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xFFF0733D),
          borderRadius: BorderRadius.circular(isSelected ? 12 : 50),
        ),
      ),
    );
  }

  Widget _stepOne() {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        child: Column(
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
    ));
  }

  Widget _stepTwo() {
    final alturaTela = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
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
    ));
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

    final documentoRGFrente = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.rgFrente);
    final documentoRGVerso = checkListDocumentos
        .firstWhereOrNull((x) => x.tipoDocumento == TipoDocumento.rgVerso);
    final documentoBO = checkListDocumentos.firstWhereOrNull(
        (x) => x.tipoDocumento == TipoDocumento.boletimOcorrencia);
    final documentoComprovante = checkListDocumentos.firstWhereOrNull(
        (x) => x.tipoDocumento == TipoDocumento.comprovanteResidencia);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: !(servicoSelected?.exigeCPF ?? true) &&
                  !(servicoSelected?.exigeCNH ?? true)
              ? "Este serviço não exige envio de documentação. Clique em próximo para continuar."
              : "Por favor, envie as imagens dos documentos solicitados abaixo, garantindo que estejam legíveis e completos.",
          size: 15,
          color: Colors.black87,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                if (servicoSelected?.exigeCPF ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoCPFFrente == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.cpfFrente);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.cpfFrente),
                    tituloDocumento: "CPF (Frente)",
                  ),
                if (servicoSelected?.exigeCPF ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoCPFVerso == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.cpfVerso);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.cpfVerso),
                    tituloDocumento: "CPF (Verso)",
                  ),
                if (servicoSelected?.exigeCNH ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoCNHFrente == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.cnhFrente);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.cnhFrente),
                    tituloDocumento: "CNH (Frente)",
                  ),
                if (servicoSelected?.exigeCNH ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoCNHVerso == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.cnhVerso);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.cnhVerso),
                    tituloDocumento: "CNH (Verso)",
                  ),
                if (servicoSelected?.exigeRG ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoRGFrente == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.rgFrente);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.rgFrente),
                    tituloDocumento: "RG (Frente)",
                  ),
                if (servicoSelected?.exigeRG ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoRGVerso == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.rgVerso);
                    },
                    carregando:
                        documentosCarregando.contains(TipoDocumento.rgVerso),
                    tituloDocumento: "RG (Verso)",
                  ),
                if (servicoSelected?.exigeBO ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoBO == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.boletimOcorrencia);
                    },
                    carregando: documentosCarregando
                        .contains(TipoDocumento.boletimOcorrencia),
                    tituloDocumento: "Boletim de Ocorrência (OFICIAL)",
                  ),
                if (servicoSelected?.exigeComprovanteResidencia ?? true)
                  DocCard(
                    exibeBotaoCapturaImagem: documentoComprovante == null,
                    capturarImagem: () {
                      _redirect(TipoDocumento.comprovanteResidencia);
                    },
                    carregando: documentosCarregando
                        .contains(TipoDocumento.comprovanteResidencia),
                    tituloDocumento: "Comprovante de Residência",
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
        : SingleChildScrollView(
            child: Column(
            spacing: 25,
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
                    spacing: 8,
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
              Column(
                children: [
                  BaseText(
                    text:
                        'Atenção! Ao realizar o agendamento, você devera comparecer no CFC para realizar assinaturas e foto (para sua CNH) Para outras duvidas, entre em contato pelo Whatsapp.',
                    size: 16,
                    color: Colors.black87,
                  ),
                ],
              ),
            ],
          ));
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
      var dataCerta = DateTime(
        horarioselectedValue!.year,
        horarioselectedValue!.month,
        horarioselectedValue!.day,
        horarioselectedValue!.hour,
        horarioselectedValue!.minute,
        horarioselectedValue!.second,
      );
      final agora = DateTime.now();

      if (dataCerta.isBefore(agora)) {
        BaseSnackbar.exibirNotificacao(
          "Erro",
          "Não é possível agendar para uma data e horário que já passaram.",
          false,
        );
      } else {
        setState(() {
          _currentStep = _currentStep + 1;
        });
      }
    }
  }

  void validaStepTree() {
    var exigeCNH = servicoSelected?.exigeCNH ?? true;
    var exigeCPF = servicoSelected?.exigeCPF ?? true;

    var qtdeDocumentosParaValidar = exigeCNH && exigeCPF
        ? 4
        : !exigeCNH && !exigeCPF
            ? 0
            : 2;

    if (checkListDocumentos.length < qtdeDocumentosParaValidar) {
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

    setState(() {
      documentosCarregando.add(tipoDocumento);
    });

    if (image != null) {
      var alunoId = await StorageService.getAlunoId();

      var documentoRenomeado =
          await Utils.renomearArquivo(image, tipoDocumento.name);

      var pathArquivoSupabase = await SupaBaseStorage().uploadImagem(
        alunoId: alunoId!,
        imagem: documentoRenomeado,
      );

      if (pathArquivoSupabase != null) {
        await AlunoService().cadastrarDocumentoAluno(DocumentoDTO(
            alunoId: alunoId,
            tipoDocumento: tipoDocumento.index,
            nomeArquivo: p.basename(documentoRenomeado.path),
            pathDocumento: pathArquivoSupabase));

        checkListDocumentos.add(ChecklistDocumentoDto(
            tipoDocumento: tipoDocumento, documento: image));
      } else {
        BaseSnackbar.exibirNotificacao(
            "Erro!",
            "Houve um erro ao fazer upload da imagem. Tente novamente mais tarde ou entre em contato com o CFC.",
            false);
      }

      setState(() {
        documentosCarregando.remove(tipoDocumento);
      });
    }
  }

  String _calculaDiasParaAgendamento() {
    final hoje = DateTime.now();
    final hojeSemHora = DateTime(hoje.year, hoje.month, hoje.day);
    final dataSelecionadaSemHora = DateTime(
        dataSelecionada.year, dataSelecionada.month, dataSelecionada.day);

    final diasDiferenca = dataSelecionadaSemHora.difference(hojeSemHora).inDays;

    if (diasDiferenca == 0) {
      return "Sua visita é hoje!";
    } else if (diasDiferenca == 1) {
      return "Sua visita é amanhã!";
    } else if (diasDiferenca > 1) {
      return "Faltam $diasDiferenca dias para a visita!";
    } else {
      return "Sua visita já passou!";
    }
  }

  _diaSelecionado(DateTime diaSelecinado, DateTime diaFocado) {
    setState(() {
      selecionouData = true;
      dataSelecionada = diaSelecinado;
    });

    _buscaHorariosDisponiveis();
  }

  void mostrarDialogConfirmacao(BuildContext context) {
    var mensagemConfirmacao = "Realmente deseja cancelar esse agendamento?";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: BaseText(
            text: 'Confirmação',
            size: 18,
            bold: true,
            color: Colors.black,
          ),
          content: BaseText(
            text: mensagemConfirmacao,
            color: Colors.black,
            bold: false,
            size: 14,
          ),
          actions: [
            BaseButton(
              text: "Sim, cancelar",
              colorFont: Colors.black,
              backgroundColor: const Color.fromARGB(255, 238, 79, 68),
              onPressed: () {
                Navigator.of(context).pop();
                Get.offAllNamed("/home");
              },
            ),
            SizedBox(
              height: 10,
            ),
            BaseButton(
              text: "Continuar",
              backgroundColor: const Color.fromARGB(255, 1, 180, 10),
              colorFont: Colors.black,
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
            ),
          ],
        );
      },
    );
  }
}
