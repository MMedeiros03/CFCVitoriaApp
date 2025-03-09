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
  @override
  void initState() {
    super.initState();

    currentRoute = Get.currentRoute;
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
            onTap: _redirectToRegisters,
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
          ItemSideBarMenu(
            icon: Icons.login_outlined,
            title: "Login",
            path: "/login",
            onTap: _redirectToRegisters,
            selected: currentRoute == "/login",
          ),
        ],
      ),
    );
  }

  _redirectToRegisters(String path) async {
    Scaffold.of(context).openDrawer();
    Get.toNamed(path);
  }
}
