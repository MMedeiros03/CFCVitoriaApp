import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class ServicoPage extends StatefulWidget{

  const ServicoPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicoPageState();

}

class ServicoPageState extends State<ServicoPage> {
  @override
  Widget build(BuildContext context) {

    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  width: larguraTela,
                  height: alturaTela * 0.14,
                  "assets/image/logo_medeiros.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              Text("MOVIMENTAÇÃO DE CARGAS PERIGOSAS - MOPP", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),

              Text("O curso de Transporte de Cargas Indivisíveis capacita motoristas para transportar cargas de grandes dimensões e pesos que não podem ser divididas, como máquinas industriais, transformadores e estruturas metálicas. O curso inclui conhecimentos sobre legislação, segurança e técnicas específicas e movimentação de cargas.",
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontSize: 15,
                  fontWeight: FontWeight.normal
              ),),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: Text("Tenho interesse")
                  )
                ],
              )
            ],
          ),

          CarouselSlider(
            options: CarouselOptions(
                height: alturaTela * 0.3,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5)),
            items: [1, 2, 3].map((i) {
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
        ],
      ),
    );
  }

}