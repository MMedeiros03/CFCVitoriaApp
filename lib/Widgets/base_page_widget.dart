import 'package:cfc_vitoria_app/Widgets/footer_widget.dart';
import 'package:cfc_vitoria_app/Widgets/header_widget.dart';
import 'package:cfc_vitoria_app/Widgets/side_bar_widget.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: const SideBarMenu(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: alturaTela * 0.10,
                  width: larguraTela,
                  child: const HeaderWidget(),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      child: widget.child),
                ),
                SizedBox(
                  height: alturaTela * 0.1,
                  width: larguraTela,
                  child: const FooterWidget(),
                )
              ],
            ),
          ),
        ));
  }
}
