import 'dart:io';

import 'package:cfc_vitoria_app/Dto/Response/Aluno/aluno_rdto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Documento/documento_rdto.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Utils/enums.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_card_documento_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future _inicializar() async {
    try {
      var aluno = await AlunoService().obterDadosAluno();

      if (!mounted) return;

      setState(() {
        alunoLogado = aluno;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

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

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Get.offAllNamed("/home");
        },
        child: BasePage(
          child: carregando
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStepIndicator(0),
                        _buildStepIndicator(1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: IndexedStack(
                        index: _currentStep,
                        children: [
                          _stepOne(),
                          _stepTwo(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BaseButton(
                        heigth: 50,
                        width: larguraTela * 0.4,
                        colorFont: Colors.black,
                        backgroundColor: const Color(0xFFF0733D),
                        onPressed: () {
                          var step = _currentStep == 0 ? 1 : 0;

                          setState(() {
                            _currentStep = step;
                          });
                        },
                        text: _currentStep == 0 ? 'Próximo' : 'Voltar',
                      ),
                    ),
                  ],
                ),
        ));
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
              BaseText(
                  text: "CPF", size: 14, bold: false, color: Colors.black38),
              BaseText(
                  text: alunoLogado?.cpf ?? "", size: 18, color: Colors.black),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: "Telefone",
                  size: 14,
                  bold: false,
                  color: Colors.black38),
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
                  text: alunoLogado?.email ?? "",
                  size: 18,
                  color: Colors.black),
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
              BaseText(
                  text: "CEP", size: 14, bold: false, color: Colors.black38),
              BaseText(
                  text: alunoLogado?.endereco?.cep ?? "",
                  size: 18,
                  color: Colors.black),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: "Rua", size: 14, bold: false, color: Colors.black38),
              BaseText(
                  text: alunoLogado?.endereco?.rua ?? "",
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
                  text: alunoLogado?.endereco?.numero ?? "",
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
                  text: alunoLogado?.endereco?.bairro ?? "",
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
                  text: alunoLogado?.endereco?.cidade ?? "",
                  size: 18,
                  color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepTwo() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: alunoLogado?.documentosAluno.length,
      itemBuilder: (context, index) {
        DocumentoRDTO documento = alunoLogado!.documentosAluno[index];

        return Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: BaseCardDocumento(
              nomeArquivo: documento.nomeArquivo,
              tipoDocumento: TipoDocumento.values[documento.tipoDocumento],
            ));
      },
    );
  }

  Widget _buildStepIndicator(int step) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentStep = step;
        });
      },
      child: Container(
        width: 70,
        height: 20,
        decoration: BoxDecoration(
            color: Color(0xFFF0733D),
            shape: _currentStep == step ? BoxShape.rectangle : BoxShape.circle,
            borderRadius:
                _currentStep == step ? BorderRadius.circular(12) : null),
      ),
    );
  }
}
