import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'base_button_widget.dart';
import 'base_text_widget.dart';

class HomeCardAnimation extends StatelessWidget {
  const HomeCardAnimation({
    super.key,
    required this.pathAnimation,
    required this.description,
    required this.path,
    required this.controller,
    required this.title,
  });

  final String description;
  final String pathAnimation;
  final String title;
  final String path;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 360;

        return Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 8, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Lottie animada
              Flexible(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1.3,
                  child: Lottie.asset(
                    pathAnimation,
                    fit: BoxFit.contain,
                    controller: controller,
                    onLoaded: (composition) {
                      controller
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Textos
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      size: isSmall ? 14 : 16,
                      maxLines: 2,
                      overflow: true,
                      color: Colors.black,
                      text: title,
                      bold: true,
                    ),
                    const SizedBox(height: 4),
                    BaseText(
                      size: 10,
                      maxLines: 3,
                      overflow: true,
                      color: Colors.black45,
                      text: description,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Flexible(
                flex: 3,
                child: SizedBox(
                  height: 35,
                  child: BaseButton(
                    width: double.infinity,
                    heigth: 35,
                    colorFont: Colors.black,
                    backgroundColor: const Color(0xFFF0733D),
                    text: "Ver",
                    fontSize: 12,
                    onPressed: () {
                      if (path == "/agendamentos") {
                        _validarERedirecionar(path);
                      } else {
                        Get.toNamed(path);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _validarERedirecionar(path) async {
    var tokenValido = await Utils.validaToken();

    if (!tokenValido) {
      Get.toNamed("/login",
          arguments: "Você precisa fazer o login para visualizar seus dados");
    } else {
      Get.offNamed(path);
    }
  }
}
