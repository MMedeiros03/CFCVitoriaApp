import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapturaImagemDocPage extends StatefulWidget {
  const CapturaImagemDocPage({super.key});

  @override
  CapturaImagemDocPageState createState() => CapturaImagemDocPageState();
}

class CapturaImagemDocPageState extends State<CapturaImagemDocPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  File? imagemCapturada;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras!.isNotEmpty) {
        controller =
            CameraController(_cameraSelecionada(), ResolutionPreset.high);

        controller!.initialize().then((_) {
          if (!mounted) return;

          setState(() {});
        });
      }
    });
  }

  CameraDescription _cameraSelecionada() {
    return cameras!.first;
  }

  Future<void> capturarImagem() async {
    if (!controller!.value.isInitialized) return;

    try {
      final XFile imagem = await controller!.takePicture();

      File imagemArquivo = File(imagem.path);

      setState(() {
        imagemCapturada = imagemArquivo;
      });

      if (mounted) {
        mostrarPopup(context, imagemArquivo);
      }
    } catch (e) {
      print('Erro ao capturar imagem: $e');
    }
  }

  void confirmaImagem() {
    Get.back(result: imagemCapturada);
    return;
  }

  void mostrarPopup(BuildContext context, File imagem) {
    final larguraTela = MediaQuery.of(context).size.width;
    final alturaTela = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
              width: larguraTela,
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  // Adicionado aqui para evitar erro
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 30,
                    children: [
                      BaseText(
                        text:
                            "Você confirma que esta imagem está legível, com boa qualidade e sem informações faltando ou cortadas?",
                        size: 14,
                        color: Colors.black,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          imagem,
                          height: constraints.maxHeight * 0.6,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                );
              })),
          actions: [
            BaseButton(
                width: larguraTela * 0.2,
                heigth: alturaTela * 0.05,
                onPressed: () => Navigator.of(context).pop(),
                text: "Repetir",
                colorFont: Colors.black,
                backgroundColor: Colors.yellow),
            BaseButton(
                width: larguraTela * 0.2,
                heigth: alturaTela * 0.05,
                onPressed: () {
                  Navigator.of(context).pop();
                  confirmaImagem();
                },
                text: "Confirmar",
                colorFont: Colors.black,
                backgroundColor: Color(0xFFF0733D)),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    } else {
      return Scaffold(
        body: SizedBox.expand(
          child: CameraPreview(controller!),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF0733D),
          onPressed: capturarImagem,
          child: Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
        ),
      );
    }
  }
}
