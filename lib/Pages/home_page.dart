import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Campanha/campanha_rdto.dart';
import 'package:cfc_vitoria_app/Services/campanha_service.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_card_campanha_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
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
    var tokenValido = await Utils.validaToken();

    var campanhas = await CampanhaService().obterCampanhas();

    var proximoAgendamento = await StorageService.getProximoAgendamento();

    if (!mounted) return;

    setState(() {
      usuarioLogado = tokenValido;
      _campanhas = campanhas;
      _proximoAgendamento = proximoAgendamento;
      carregando = false;
    });
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
                          text: "aluno!",
                          bold: false,
                          size: 17,
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
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
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            BaseText(
                                text: "Próximo Agendamento ",
                                size: 20,
                                bold: true,
                                color: Colors.black),
                            Container(
                              width: larguraTela,
                              height: alturaTela * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 50,
                                    color: Color(0xFFF0733D),
                                  ),
                                  SizedBox(width: 8),
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
                                        SizedBox(height: 4),
                                        BaseText(
                                          text:
                                              _proximoAgendamento!.contagemDias,
                                          size: 12,
                                          color: Colors.black45,
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: BaseButton(
                                      width: 65,
                                      heigth: 35,
                                      colorFont: Colors.black,
                                      backgroundColor: Color(0xFFF0733D),
                                      text: "Ver",
                                      fontSize: 14,
                                      onPressed: () {
                                        Get.toNamed("/agendamento",
                                            arguments: _proximoAgendamento);
                                      },
                                    ),
                                  )
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
                    if (!usuarioLogado)
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
}
