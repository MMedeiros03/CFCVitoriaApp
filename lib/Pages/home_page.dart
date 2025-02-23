import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_page_widget.dart';
import 'package:flutter/material.dart';
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

          Row(
            children: [
              Icon(Icons.person_outlined, size: 50,),
              Text("Bem vindo!")
            ],
          ),

          CarouselSlider(
            options: CarouselOptions(
                height: alturaTela * 0.2,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5)),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: larguraTela,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.black12),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
          ),
          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
              title: "Serviços",
              description: "Serviços",
              pathAnimation: 'assets/animations/LearnAnimation.json',
            ),
          ),

          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
              title: "Agende sua consulta!",
              description: "Agende sua consulta!",
              pathAnimation: 'assets/animations/VisitAnimation.json',
            ),
          ),


          SizedBox(
            width: larguraTela,
            height: alturaTela * 0.12,
            child: HomeCardAnimation(
              title: "Agendamentos",
              description: "Agendamentos",
              pathAnimation: 'assets/animations/CalendarAnimation.json',
            )
          ),

        ],
      ),
    );
  }
}
