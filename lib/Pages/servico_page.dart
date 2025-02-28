import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class ServicoPage extends StatefulWidget {
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/image/logo_medeiros.jpg",
                width: larguraTela,
                height: alturaTela * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Título
            BaseText(
              text: "MOVIMENTAÇÃO DE CARGAS PERIGOSAS - MOPP",
              size: 15,
              bold: true,
              alignText: true,
              color: Colors.black,
            ),
            SizedBox(height: 10),

            // Descrição
            BaseText(
              text:
                  "O curso de Transporte de Cargas Indivisíveis capacita motoristas para transportar cargas de grandes dimensões e pesos que não podem ser divididas, como máquinas industriais, transformadores e estruturas metálicas. O curso inclui conhecimentos sobre legislação, segurança e técnicas específicas e movimentação de cargas.",
              alignText: false,
              justifyText: true,
              size: 13,
              bold: false,
              color: Colors.black87,
            ),
            SizedBox(height: 15),

            // Botão
            Align(
              alignment: Alignment.centerRight,
              child: BaseButton(
                width: 140,
                heigth: 45,
                fontSize: 13,
                backgroundColor: Color(0xFFF0733D),
                colorFont: Colors.black,
                onPressed: () {},
                text: "Tenho interesse",
              ),
            ),
            SizedBox(height: 20),

            // Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: alturaTela * 0.4,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
              ),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: larguraTela * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.black12,
                      ),
                      child: Center(
                        child: Text(
                          'Imagem $i',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
