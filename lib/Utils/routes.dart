import 'package:cfc_vitoria_app/Pages/meus_dados_page.dart';
import 'package:cfc_vitoria_app/Pages/sem_internet_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Pages/agendamento_page.dart';
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
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/servico',
          page: () => ServicoPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/servicos',
          page: () => ServicosPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/sobreNos',
          page: () => SobreNosPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/agendamento',
          page: () => AgendamentoPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/agendamentos',
          page: () => AgendamentosPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/meusDados',
          page: () => MeusDadosPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
      GetPage(
          name: '/semInternet',
          page: () => SemInternetPage(),
          transition: Transition.rightToLeftWithFade,
          opaque: false),
    ];
  }
}
