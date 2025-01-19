import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/home_card_animation.dart';

class HomePage extends StatefulWidget {

 const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: alturaTela * 0.2,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5)
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: larguraTela,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.black12
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                  );
                },
              );
            }).toList(),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 14.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [

              HomeCardAnimation(
                title: "Serviços",
                pathAnimation: 'assets/animations/LearnAnimation.json',
              ),

              HomeCardAnimation(
                title: "Agende sua consulta!",
                pathAnimation: 'assets/animations/VisitAnimation.json',
              ),

              HomeCardAnimation(
                title: "Agendamentos",
                pathAnimation: 'assets/animations/CalendarAnimation.json',
              ),

              HomeCardAnimation(
                title: "Sobre nós",
                pathAnimation: 'assets/animations/AboutAnimation.json',
              ),
            ],
          )

          // Lottie.asset(
          //   'assets/animations/Animation - 1736982305071.json',
          //   width: 250,
          //   height: 250,
          //   fit: BoxFit.fill,
          // )

        ],
      ),
    );
  }

}