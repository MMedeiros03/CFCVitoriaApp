import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseText(text: "Carregando...", size: 15, color: Colors.black),
                Lottie.asset(
                  'assets/animations/LoadingAnimation.json',
                  width: larguraTela,
                  height: 50,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ));
  }
}
