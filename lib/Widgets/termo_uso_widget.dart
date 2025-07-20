import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

class TermoUso extends StatefulWidget {
  const TermoUso({super.key});

  @override
  State<TermoUso> createState() => TermoUsoState();
}

class TermoUsoState extends State<TermoUso> {
  void confirmaTermoResponsabilidade() async {
    await StorageService.setAceitouTermo(true);
  }

  bool marcado = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {},
        child: StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: BaseText(
              text: 'Termos de Uso e Política de Privacidade',
              size: 18,
              bold: true,
              alignText: true,
              color: Colors.black,
            ),
            content: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  BaseText(
                    justifyText: true,
                    bold: false,
                    text:
                        'Bem-vindo ao nosso aplicativo. Ao utilizá-lo, você declara que leu, compreendeu e concorda com os termos descritos a seguir.\n\n'
                        'Este documento tem como objetivo apresentar de forma clara as condições de uso do aplicativo, bem como explicar como tratamos seus dados pessoais, garantindo transparência e respeito à sua privacidade.',
                    size: 13,
                    color: Colors.black,
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        alignText: false,
                        text: '1. Finalidade do Aplicativo',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Este aplicativo tem como objetivo facilitar a comunicação entre o CFC Vitoria e seus futuros alunos, oferecendo uma plataforma prática para a divulgação dos serviços prestados, como serviços e pacotes de habilitação, e permitindo o agendamento rápido de atendimentos presenciais na unidade física. A proposta é tornar mais ágil o processo de início do aluno na auto escola, otimizando o atendimento e reduzindo etapas burocráticas.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '2. Aceite dos Termos',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Ao acessar e utilizar o aplicativo, o usuário concorda expressamente com todos os termos aqui apresentados. Caso não concorde com qualquer condição, recomendamos que interrompa o uso imediatamente.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '3. Dados Coletados',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Durante o uso do aplicativo, poderão ser coletados os seguintes dados pessoais: \n\n'
                            'Informações de cadastro: nome completo, e-mail, telefone, CPF e endereço; \n'
                            'Anexo de documentos: o usuário poderá enviar fotos ou digitalizações de documentos necessários para o processo de matrícula ou atendimento na autoescola. \n\n'
                            'Esses dados são utilizados exclusivamente para fins operacionais da autoescola, como identificação do aluno, validação de informações e agilização do processo de atendimento e matrícula.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '4. Uso e Compartilhamento de Dados',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text: 'Seus dados poderão ser utilizados para: \n\n'
                            'Identificar o usuário e fornecer os serviços oferecidos; \n'
                            'Realizar melhorias contínuas na experiência do app; \n'
                            'Cumprir obrigações legais ou regulatórias; \n'
                            'Proteger direitos, prevenir fraudes ou atender requisições judiciais. \n\n'
                            'O compartilhamento de dados com terceiros ocorrerá apenas quando estritamente necessário para o funcionamento do aplicativo, com prestadores de serviço que atuam sob cláusulas de confidencialidade e proteção de dados.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '5. Responsabilidades do Usuário',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text: 'O usuário é responsável: \n\n'
                            'Pela veracidade das informações fornecidas no aplicativo; \n'
                            'Por não compartilhar seus dados de acesso com terceiros; \n'
                            'Por manter seus dados cadastrais atualizados; \n'
                            'Não nos responsabilizamos por informações inseridas de forma equivocada ou pelo uso indevido do aplicativo.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '6. Segurança da Informação',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Adotamos medidas técnicas e administrativas para proteger os dados dos usuários contra acessos não autorizados, perda, destruição ou alteração. Mesmo assim, nenhuma transmissão de dados na internet é 100% segura, por isso recomendamos cautela ao compartilhar informações sensíveis.',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '7. Armazenamento e Exclusão dos Dados',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Seus dados serão armazenados pelo tempo necessário para a prestação dos serviços, ou conforme exigido por lei. Você poderá, a qualquer momento, solicitar a  correção ou exclusão dos seus dados pessoais, conforme previsto na Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018).',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        bold: true,
                        text: '8. Contato',
                        size: 16,
                        color: Colors.black,
                      ),
                      BaseText(
                        justifyText: true,
                        bold: false,
                        text:
                            'Em caso de dúvidas ou solicitações de atualizações cadastrais, entre em contato conosco através do WhatsAppp: +55 51 3450-3939',
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseText(
                          bold: true,
                          alignText: true,
                          text:
                              "Li e concordo com o Termo de Responsabilidade de Uso do Aplicativo.",
                          size: 14,
                          color: Colors.black),
                      Checkbox(
                        activeColor: Colors.black12,
                        checkColor: Colors.green,
                        value: marcado,
                        onChanged: (bool? newValue) {
                          setState(() {
                            marcado = newValue!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              BaseButton(
                showButton: marcado,
                text: "Confirmar",
                colorFont: Colors.black,
                backgroundColor: Color(0xFFF0733D),
                onPressed: () {
                  confirmaTermoResponsabilidade();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }));
  }
}
