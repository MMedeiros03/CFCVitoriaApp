import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'base_button_widget.dart';

class HomeCardAnimation extends StatelessWidget{
  const HomeCardAnimation({
    super.key,
    required this.pathAnimation,
    required this.description,
    required this.title
  });

  final String description;
  final String pathAnimation;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xFFD9D9D9),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 8, left: 8, top: 8,bottom: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Lottie.asset(
                  width: 120,
                  height: 100,
                  frameRate: FrameRate(90),
                  pathAnimation,
                  fit: BoxFit.fill,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(description),
                    ],
                  ),
              ],
            ),


            SizedBox(width: 3),

            BaseButton(
              width: 110,
              heigth: 32,
              colorFont: Colors.black,
              backgroundColor: Color(0xFFF0733D),
              text: "Ver",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

}