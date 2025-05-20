import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                          "Confira a estrutura completa do nosso CFC, pensada para oferecer conforto e segurança durante o seu aprendizado. Espaço pensado para garantir um ambiente agradável e equipado com tudo o que você precisa para se preparar da melhor forma.",
                      size: 13,
                      color: Colors.black45),
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
                                  BorderRadius.all(Radius.circular(12)),
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
                          "Nosso CFC está de portas abertas para te receber! Estamos localizados na Av. Sapucaia, número 1899, no bairro Estação do Trem, em Sapucaia do Sul/RS. Funcionamos de segunda a sexta, das 9h às 18h, sempre prontos para te atender com carinho e atenção. Se precisar de um ponto de referência, estamos bem em frente à praça principal. Esperamos sua visita!",
                      size: 13,
                      color: Colors.black45),
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
                          "Se tiver dúvidas, quiser mais informações ou precisar de ajuda com algum serviço, estamos à disposição nos nossos canais de atendimento. É só entrar em contato com a gente pelo WhatsApp, telefone ou redes sociais. Vai ser um prazer falar com você!",
                      size: 13,
                      color: Colors.black45),
                  Row(
                    spacing: 15,
                    children: [
                      Icon(
                        Icons.public_outlined,
                        color: Color(0xFFF0733D),
                        size: 40,
                      ),
                      BaseText(
                          text: "http://www.cfcvitoriasapucaia.com/",
                          size: 14,
                          color: Colors.black)
                    ],
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xFFF0733D),
                        size: 40,
                      ),
                      BaseText(
                          text: "@cfcvitoriasapucaia",
                          size: 14,
                          color: Colors.black)
                    ],
                  ),
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
                          text: "(51) 3450-3939", size: 15, color: Colors.black)
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
