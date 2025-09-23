import 'package:carousel_slider/carousel_slider.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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

  final List<String> imagensCfc = [
    'assets/image/cfc1.jpg',
    'assets/image/cfc2.jpeg',
    'assets/image/cfc3.jpeg',
    'assets/image/cfc5.jpeg',
    'assets/image/cfc6.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Get.offAllNamed("/home");
        },
        child: BasePage(
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
                                0.55, // Define um max-width para o texto
                            child: BaseText(
                              justifyText: true,
                              bold: false,
                              maxLines: 10,
                              text:
                                  "O CFC Vitoria é uma autoescola comprometida com a formação de condutores responsáveis, seguros, conscientes do seu papel no trânsito. Localizado na parte central de Sapucaia do Sul, o CFC Vitoria oferece atendimento personalizado, instrutores qualificados e estrutura acolhedora para garantir que cada aluno receba uma formação completa e de qualidade.\n"
                                  "Nosso compromisso vai além de preparar motoristas para obter a habilitação. Trabalhamos para formar cidadãos que compreendem a importância da segurança, do respeito às leis e da realização para a conquista da CNH.\n"
                                  "Seja para sua primeira habilitação ou para demais serviços, o CFC Vitoria é a escolha certa para quem busca confiança, agilidade e um ensino humanizado. Oferecendo serviços com excelência e contribuindo para um trânsito mais seguro para todos.",
                              size: 13,
                              color: Colors.black38,
                            ),
                          ),
                          Spacer(), // Empurra a imagem para o final da linha
                          Image.asset(
                            "assets/image/logo_transparente.png",
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
                        text: "Missão",
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
                              "Formar condutores conscientes, responsáveis e preparados, contribuindo para um trânsito mais seguro e humanizado. Oferecemos ensino de qualidade, aliado a valores éticos e ao respeito às leis de trânsito, para que cada aluno desenvolva, não apenas as habilidades técnicas para conduzir um veículo, mas também uma postura cidadã.",
                          size: 13,
                          color: Colors.black45),
                    ],
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
                        text: "Visão",
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
                              "Ser como o Centro de Formação de Condutores referência na região, pela excelência no ensino, inovação nos métodos de aprendizagem, compromisso com a formação de motoristas.",
                          size: 13,
                          color: Colors.black45),
                    ],
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
                          height: alturaTela * 0.33,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                        ),
                        items: imagensCfc.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: larguraTela * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Colors.black12,
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.asset(
                                      fit: BoxFit.cover,
                                      i,
                                    ),
                                  ));
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
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Color(0xFFF0733D),
                            size: 40,
                          ),
                          BaseText(
                              text: "cfcvitoriasapucaia",
                              size: 15,
                              color: Colors.black)
                        ],
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Color(0xFFF0733D),
                            size: 40,
                          ),
                          BaseText(
                              text: "(51) 3450-3939",
                              size: 15,
                              color: Colors.black)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )));
  }
}
