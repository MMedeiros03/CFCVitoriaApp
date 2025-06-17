import 'package:cfc_vitoria_app/Utils/customFABLocation.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/footer_widget.dart';
import 'package:cfc_vitoria_app/Widgets/header_widget.dart';
import 'package:cfc_vitoria_app/Widgets/side_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.child});

  final Widget child;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  Future<void> abrirWhatsApp() async {
    final url = Uri.parse('https://wa.me/555134503939');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "Não foi possivel redirecionar para a localização", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: const SideBarMenu(),
        floatingActionButtonLocation: CustomFABLocation(
          xOffset: -(larguraTela * 0.02),
          yOffset: -(alturaTela * 0.070),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await abrirWhatsApp();
          },
          mini: true,
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 107, 235, 111),
          child: const FaIcon(FontAwesomeIcons.whatsapp),
        ),
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
