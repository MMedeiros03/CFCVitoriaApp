import 'package:cfc_vitoria_app/Pages/agendamento_page.dart';
import 'package:cfc_vitoria_app/Pages/cadastro_aluno_page.dart';
import 'package:cfc_vitoria_app/Pages/captura_imagem_doc_page.dart';
import 'package:cfc_vitoria_app/Pages/login_page.dart';
import 'package:cfc_vitoria_app/Pages/meus_dados_page.dart';
import 'package:cfc_vitoria_app/Pages/sem_internet_page.dart';
import 'package:cfc_vitoria_app/Pages/tutorial_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Pages/createAgendamento_page.dart';
import '../Pages/agendamentos_page.dart';
import '../Pages/home_page.dart';
import '../Pages/servico_page.dart';
import '../Pages/servicos_page.dart';
import '../Pages/sobre_nos_page.dart';

class Routes {
  static getRoutes() {
    return [
      GetPage(
          name: '/home',
          page: () => HomePage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/servico',
          page: () => ServicoPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/servicos',
          page: () => ServicosPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/sobreNos',
          page: () => SobreNosPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/create-agendamento',
          page: () => CreateAgendamentoPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/agendamentos',
          page: () => AgendamentosPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/meusDados',
          page: () => MeusDadosPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/semInternet',
          page: () => SemInternetPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/tutorial',
          page: () => TutorialPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/agendamento',
          page: () => AgendamentoPage(),
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/cadastro-aluno',
          page: () => CadastroAlunoPage(),
          arguments: "",
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/login',
          page: () => LoginPage(),
          arguments: "",
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
      GetPage(
          name: '/captura-imagem',
          page: () => CapturaImagemDocPage(),
          arguments: "",
          transitionDuration: Duration(milliseconds: 100),
          transition: Transition.fade,
          opaque: true),
    ];
  }
}
