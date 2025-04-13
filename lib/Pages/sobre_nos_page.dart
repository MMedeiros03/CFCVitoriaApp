import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/base_page_widget.dart';

class SobreNosPage extends StatefulWidget {
  const SobreNosPage({super.key});

  @override
  State<StatefulWidget> createState() => SobreNosPageState();
}

class SobreNosPageState extends State<SobreNosPage> {
  Future<void> _openGoogleMaps() async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=CFC+VITORIA+AUTO+MOTO+ESCOLA');

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

    return BasePage(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BaseText(
                    color: Colors.black,
                    text: "Sobre nós",
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Color(0xFFF0733D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth *
                            0.5, // Define um max-width para o texto
                        child: BaseText(
                          justifyText: true,
                          bold: false,
                          maxLines: 10,
                          text:
                              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model.",
                          size: 13,
                          color: Colors.black38,
                        ),
                      ),
                      Spacer(), // Empurra a imagem para o final da linha
                      Image.asset(
                        "assets/image/logo_cfc.jpg",
                        width: constraints.maxWidth * 0.4,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BaseText(
                    color: Colors.black,
                    text: "Nossa Estrutura",
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Color(0xFFF0733D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                spacing: 20,
                children: [
                  BaseText(
                      justifyText: true,
                      bold: false,
                      text:
                          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                      size: 13,
                      color: Colors.black38),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: alturaTela * 0.3,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: larguraTela * 0.7,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
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
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                children: [
                  BaseText(
                    color: Colors.black,
                    text: "Nosso Endereço",
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Color(0xFFF0733D),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                children: [
                  BaseText(
                      justifyText: true,
                      bold: false,
                      text:
                          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                      size: 13,
                      color: Colors.black38),
                ],
              ),
              InkWell(
                onTap: _openGoogleMaps,
                child: SizedBox(
                  width: larguraTela,
                  height: alturaTela * 0.2,
                  child: Image.asset(
                    fit: BoxFit.cover,
                    "assets/image/localizacao.png",
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BaseText(
                    color: Colors.black,
                    text: "Contato",
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Color(0xFFF0733D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                spacing: 20,
                children: [
                  BaseText(
                      justifyText: true,
                      bold: false,
                      text:
                          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                      size: 13,
                      color: Colors.black38),
                  Row(
                    spacing: 15,
                    children: [
                      Icon(
                        Icons.email,
                        color: Color(0xFFF0733D),
                        size: 40,
                      ),
                      BaseText(
                          text: "cfcvitoria2025@gmail.com",
                          size: 15,
                          color: Colors.black)
                    ],
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color(0xFFF0733D),
                        size: 40,
                      ),
                      BaseText(
                          text: "(12) 912345678", size: 15, color: Colors.black)
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
