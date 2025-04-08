import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'base_button_widget.dart';

class HomeCardAnimation extends StatelessWidget {
  const HomeCardAnimation(
      {super.key,
      required this.pathAnimation,
      required this.description,
      required this.path,
      required this.controller,
      required this.title});

  final String description;
  final String pathAnimation;
  final String title;
  final String path;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.black12,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 8, left: 0, top: 8, bottom: 2),
        child:
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  width: 130,
                  height: 100,
                  frameRate: FrameRate(90),
                  pathAnimation,
                  fit: BoxFit.fill,
                  controller: controller,
                  onLoaded: (composition) {
                    controller
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      spacing: 5,
                      children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: BaseText(
                              size: 16,
                              maxLines: 2,
                              overflow: true,
                              color: Colors.black,
                              text: title,
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: BaseText(
                              size: 11,
                              maxLines: 3,
                              overflow: true,
                              color: Colors.black45,
                              text: description,
                            ),

                          ),
                      ],
                    ),
                  ],
                ),
                BaseButton(
                  width: constraints.maxWidth * 0.15,
                  heigth: 35,
                  colorFont: Colors.black,
                  backgroundColor: Color(0xFFF0733D),
                  text: "Ver",
                  fontSize: 14,
                  onPressed: () {
                    Get.toNamed(path);
                  },
                ),
              ],
            );
          }),
      ),
    );
  }
}
