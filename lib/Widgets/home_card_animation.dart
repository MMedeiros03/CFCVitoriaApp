import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeCardAnimation extends StatelessWidget{
  const HomeCardAnimation({
    super.key,
    required this.pathAnimation,
    required this.title
  });

  final String pathAnimation;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.black12
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Lottie.asset(
              frameRate: FrameRate(90),
              pathAnimation,
              fit: BoxFit.cover,
            ),
          ],
        )
      )
    );
  }

}