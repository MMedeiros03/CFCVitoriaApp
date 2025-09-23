import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/item_sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  SideBarMenuState createState() => SideBarMenuState();
}

class SideBarMenuState extends State<SideBarMenu> {
  bool usuarioLogado = false;

  @override
  void initState() {
    super.initState();
    currentRoute = Get.currentRoute;
    _inicializar();
  }

  _inicializar() async {
    var tokenValido = await Utils.validaToken();

    if (!mounted) return;

    setState(() {
      usuarioLogado = tokenValido;
    });
  }

  late String currentRoute = "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ItemSideBarMenu(
            icon: Icons.home_outlined,
            title: "Home",
            path: "/home",
            onTap: _redirectToRegisters,
            selected: currentRoute == "/home",
          ),
          ItemSideBarMenu(
            icon: Icons.book_outlined,
            title: "Serviços",
            path: "/servicos",
            onTap: _redirectToRegisters,
            selected: currentRoute == "/servicos",
          ),
          ItemSideBarMenu(
            icon: Icons.calendar_month_outlined,
            title: "Agendamentos",
            path: "/agendamentos",
            onTap: _validarERedirecionar,
            selected: currentRoute == "/agendamentos",
          ),
          ItemSideBarMenu(
            icon: Icons.phone_outlined,
            title: "Sobre Nós",
            path: "/sobreNos",
            onTap: _redirectToRegisters,
            selected: currentRoute == "/sobreNos",
          ),
          ItemSideBarMenu(
            icon: Icons.info_outline,
            title: "Tutorial",
            path: "/tutorial",
            onTap: _redirectToRegisters,
            selected: currentRoute == "/tutorial",
          ),
          if (!usuarioLogado)
            ItemSideBarMenu(
              icon: Icons.login_outlined,
              title: "Entrar",
              path: "/login",
              onTap: _redirectToRegisters,
              selected: currentRoute == "/login",
            ),
          if (usuarioLogado)
            ItemSideBarMenu(
              icon: Icons.logout_outlined,
              title: "Sair",
              path: "/login",
              onTap: _logOutAluno,
              selected: currentRoute == "/login",
            ),
        ],
      ),
    );
  }

  Future _validarERedirecionar(path) async {
    var tokenValido = await Utils.validaToken();

    if (mounted) {
      Scaffold.of(context).closeDrawer();
    }

    if (!tokenValido) {
      Get.toNamed("/login",
          arguments: "Você precisa fazer o login para visualizar seus dados");
    } else {
      Get.offNamed(path);
    }
  }

  _logOutAluno(String path) async {
    await StorageService.removeToken(true);
    await StorageService.removeAlunoId();
    await StorageService.removeListaDocumentosAluno();

    if (mounted) {
      Scaffold.of(context).closeDrawer();
    }

    Get.offNamed(path);
  }

  _redirectToRegisters(String path) async {
    if (mounted) {
      Scaffold.of(context).closeDrawer();
    }
    Get.offNamed(path);
  }
}
