import 'package:flutter/material.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  SideBarMenuState createState() => SideBarMenuState();
}

class SideBarMenuState extends State<SideBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              onTap: () {
                _redirectToRegisters();
              },
              title: const Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Cadastro")
                ],
              )),
          ListTile(
              onTap: () {
                _redirectToRegisters();
              },
              title: const Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Agendamentos")
                ],
              )),
          ListTile(
              onTap: () {
                _redirectToRegisters();
              },
              title: const Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Serviços")
                ],
              )),
          ListTile(
              onTap: () {
                _redirectToRegisters();
              },
              title: const Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Promoções")
                ],
              )),
        ],
      ),
    );
  }

  _redirectToRegisters() async {
    Scaffold.of(context).openDrawer();
    // await BaseAnimatePage.navigate(context, const TransactionsScreen());
  }
}
