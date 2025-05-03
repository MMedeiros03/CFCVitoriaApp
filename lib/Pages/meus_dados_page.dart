import 'dart:io';

import 'package:cfc_vitoria_app/Dto/Response/Aluno/aluno_rdto.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/base_page_widget.dart';

class MeusDadosPage extends StatefulWidget {
  const MeusDadosPage({super.key});

  @override
  State<StatefulWidget> createState() => MeusDadosPageState();
}

class MeusDadosPageState extends State<MeusDadosPage> {
  File? imageFile;
  bool carregando = true;
  AlunoRDTO? alunoLogado;

  int _currentStep = 0;

  String? _imagePath;

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future _inicializar() async {
    try {
      var aluno = await AlunoService().obterDadosAluno();

      setState(() {
        alunoLogado = aluno;
        carregando = false;
      });
    } catch (e) {
      BaseSnackbar.exibirNotificacao(
          "Erro", "Erro ao tentar buscar suas informações.", false);

      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: carregando
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20),

                  // Indicador de progresso
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStepIndicator(0),
                      _buildStepIndicator(1),
                    ],
                  ),

                  // Formulário com IndexedStack
                  SizedBox(height: 20),

                  IndexedStack(
                    index: _currentStep,
                    children: [
                      _stepOne(),
                      _stepTwo(),
                    ],
                  ),

                  SizedBox(height: 20),

                  if (_currentStep == 0)
                    BaseButton(
                      heigth: 50,
                      width: larguraTela * 0.4,
                      colorFont: Colors.black,
                      backgroundColor: Color(0xFFF0733D),
                      onPressed: () {
                        if (_currentStep == 0) {
                          setState(() {
                            _currentStep = 1;
                          });
                        } else {}
                      },
                      text: 'Próximo',
                    ),
                ],
              ),
            ),
    );
  }

  Widget _stepOne() {
    return SingleChildScrollView(
        child: Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BaseText(
              color: Colors.black,
              text: "Dados Pessoais",
              size: 25,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Nome", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.nome ?? "", size: 18, color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(text: "CPF", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.cpf ?? "", size: 18, color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Telefone", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.telefone ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Email", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.email ?? "", size: 18, color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Data de Nascimento",
                size: 14,
                bold: false,
                color: Colors.black38),
            BaseText(
                text: alunoLogado?.dataNascimento != null
                    ? DateFormat("dd/MM/yyyy")
                        .format(alunoLogado!.dataNascimento)
                    : "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Row(
          children: [
            BaseText(
              color: Colors.black,
              text: "Endereço",
              size: 25,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(text: "CEP", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.endereco.cep ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(text: "Rua", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.endereco.rua ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Numero", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.endereco.numero ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Bairro", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.endereco.bairro ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
                text: "Cidade", size: 14, bold: false, color: Colors.black38),
            BaseText(
                text: alunoLogado?.endereco.cidade ?? "",
                size: 18,
                color: Colors.black),
          ],
        ),
      ],
    ));
  }

  Widget _stepTwo() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _imagePath = 'imagem_selecionada.png'; // Simulação
            });
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: _imagePath == null
                ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey[700])
                : Image.asset(_imagePath!, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 20),
        BaseText(
          size: 10,
          color: Colors.black,
          text: _imagePath == null
              ? 'Clique para adicionar uma imagem'
              : 'Imagem selecionada',
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int step) {
    return Container(
      width: 70,
      height: 20,
      decoration: BoxDecoration(
          color: Color(0xFFF0733D),
          shape: _currentStep == step ? BoxShape.rectangle : BoxShape.circle,
          borderRadius:
              _currentStep == step ? BorderRadius.circular(12) : null),
    );
  }

  // void _showOpcoesBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: CircleAvatar(
  //                 backgroundColor: Colors.grey[200],
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.abc,
  //                     color: Colors.grey[500],
  //                   ),
  //                 ),
  //               ),
  //               title: Text(
  //                 'Galeria',
  //                 style: Theme.of(context).textTheme.bodyLarge,
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 // Buscar imagem da galeria
  //                 pick(ImageSource.gallery);
  //               },
  //             ),
  //             ListTile(
  //               leading: CircleAvatar(
  //                 backgroundColor: Colors.grey[200],
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.abc,
  //                     color: Colors.grey[500],
  //                   ),
  //                 ),
  //               ),
  //               title: Text(
  //                 'Câmera',
  //                 style: Theme.of(context).textTheme.bodyLarge,
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 // Fazer foto da câmera
  //                 pick(ImageSource.camera);
  //               },
  //             ),
  //             ListTile(
  //               leading: CircleAvatar(
  //                 backgroundColor: Colors.grey[200],
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.abc,
  //                     color: Colors.grey[500],
  //                   ),
  //                 ),
  //               ),
  //               title: Text(
  //                 'Remover',
  //                 style: Theme.of(context).textTheme.bodyLarge,
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 // Tornar a foto null
  //                 setState(() {
  //                   imageFile = null;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
