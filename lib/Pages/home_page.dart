import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Campanha/campanha_rdto.dart';
import 'package:cfc_vitoria_app/Services/agendamento_service.dart';
import 'package:cfc_vitoria_app/Services/campanha_service.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_card_campanha_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:cfc_vitoria_app/Widgets/reset_senha_widget.dart';
import 'package:cfc_vitoria_app/Widgets/termo_uso_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Widgets/home_card_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool carregando = true;
  late bool usuarioLogado = false;
  AgendamentoRDTO? _proximoAgendamento;
  late List<CampanhaRDTO> _campanhas;
  String _nomeAluno = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _inicializar();
  }

  _inicializar() async {
    try {
      var tokenValido = await Utils.validaToken();

      var campanhas = await CampanhaService().obterCampanhas();

      var proximoAgendamento = tokenValido
          ? await AgendamentoService().obterProximoAgendamento()
          : null;

      var nomeAluno = await StorageService.getAlunoNome();

      var aceitouTermo = await StorageService.getAceitouTermo();

      var resetarSenha = await StorageService.getSolicitouResetSenha();

      if (!aceitouTermo) {
        if (mounted) {
          abrirTermoResponsabilidade(context);
        }
      }

      if (resetarSenha && tokenValido) {
        if (mounted) {
          abrirResetSenha(context);
        }
      }

      if (!mounted) return;

      setState(() {
        usuarioLogado = tokenValido;
        _campanhas = campanhas;
        _proximoAgendamento = proximoAgendamento;
        _nomeAluno = nomeAluno ?? "";
        carregando = false;
      });
    } catch (e) {
      BaseSnackbar.exibirNotificacao(
          "Erro",
          "Houve um erro na inicialização. Entre em contato com o suporte!",
          false);

      setState(() {
        usuarioLogado = false;
        _campanhas = [];
        _proximoAgendamento = null;
        _nomeAluno = "";
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: carregando
          ? Center(child: CircularProgressIndicator(color: Colors.black))
          : SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 30,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.person_outlined,
                      size: 55,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          text: "Bem vindo,",
                          bold: true,
                          size: 17,
                          color: Colors.black,
                        ),
                        BaseText(
                          text: usuarioLogado ? "aluno $_nomeAluno!" : "aluno!",
                          bold: false,
                          size: 17,
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
                if (_campanhas.isNotEmpty)
                  CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: _campanhas.length > 1,
                        autoPlay: _campanhas.length > 1,
                        height: alturaTela * 0.24,
                        viewportFraction: _campanhas.length > 1 ? 0.9 : 1,
                        autoPlayInterval: Duration(seconds: 5)),
                    items: _campanhas.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return BaseCardCampanha(
                            campanha: i,
                          );
                        },
                      );
                    }).toList(),
                  ),
                Column(
                  spacing: 10,
                  children: [
                    if (_proximoAgendamento != null && usuarioLogado)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: BaseText(
                                text: "Próximo Agendamento",
                                size: 20,
                                bold: true,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: larguraTela,
                              height: alturaTela * 0.115,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 50,
                                    color: const Color(0xFFF0733D),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        BaseText(
                                          text: DateFormat("dd/MM/yyyy - HH:mm")
                                              .format(_proximoAgendamento!
                                                  .dataHoraAgendado),
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 4),
                                        BaseText(
                                          text:
                                              _proximoAgendamento!.contagemDias,
                                          size: 12,
                                          color: Colors.black45,
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: BaseButton(
                                      width: 65,
                                      heigth: 35,
                                      colorFont: Colors.black,
                                      backgroundColor: const Color(0xFFF0733D),
                                      text: "Ver",
                                      fontSize: 14,
                                      onPressed: () {
                                        Get.toNamed(
                                          "/agendamento",
                                          arguments: _proximoAgendamento,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: larguraTela,
                      height: alturaTela * 0.12,
                      child: HomeCardAnimation(
                        controller: _controller,
                        path: "/servicos",
                        title: "Serviços",
                        description:
                            "Conheça os serviços que temos disponiveis para você",
                        pathAnimation: 'assets/animations/LearnAnimation.json',
                      ),
                    ),
                    if (!usuarioLogado ||
                        (usuarioLogado && _proximoAgendamento == null))
                      SizedBox(
                        width: larguraTela,
                        height: alturaTela * 0.12,
                        child: HomeCardAnimation(
                          controller: _controller,
                          path: "/agendamentos",
                          title: "Agendamentos",
                          description: "Veja o seu histórico de agendamentos ",
                          pathAnimation:
                              'assets/animations/CalendarAnimation.json',
                        ),
                      ),
                    SizedBox(
                        width: larguraTela,
                        height: alturaTela * 0.12,
                        child: HomeCardAnimation(
                          controller: _controller,
                          path: "/sobreNos",
                          title: "Sobre nós",
                          description: "Conheça um pouco mais sobre nosso CFC!",
                          pathAnimation:
                              'assets/animations/AboutAnimation.json',
                        )),
                  ],
                )
              ],
            )),
    );
  }

  void abrirTermoResponsabilidade(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return TermoUso();
      },
    );
  }

  void abrirResetSenha(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ResetSenha();
      },
    );
  }
}
