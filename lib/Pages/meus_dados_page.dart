import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../Widgets/base_page_widget.dart';

class MeusDadosPage extends StatefulWidget {
  const MeusDadosPage({super.key});

  @override
  State<StatefulWidget> createState() => MeusDadosPageState();
}

class MeusDadosPageState extends State<MeusDadosPage> {
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar os dados do formulário
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 30,
        children: [
          // Indicador de progresso
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepIndicator(0),
              _buildStepIndicator(1),
            ],
          ),

          // Formulário com IndexedStack
          IndexedStack(
            index: _currentStep,
            children: [
              _stepOne(),
              _stepTwo(),
            ],
          ),

          // Botões de navegação
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentStep > 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  child: Text('Voltar'),
                ),
              ElevatedButton(
                onPressed: () {
                  if (_currentStep == 0) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _currentStep = 1;
                      });
                    }
                  } else {
                    // Aqui você pode processar os dados do formulário
                    print('Nome: ${_nameController.text}');
                    print('E-mail: ${_emailController.text}');
                    print('Telefone: ${_phoneController.text}');
                    print('Imagem: $_imagePath');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Formulário enviado!')),
                    );
                  }
                },
                child: Text(_currentStep == 0 ? 'Próximo' : 'Finalizar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Etapa 1: Informações básicas
  Widget _stepOne() {
    final alturaTela = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Container(
          height: alturaTela * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF0733D), width: 1),
            color: Color(0x4DD9D9D9),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) =>
                      value!.isEmpty ? 'Preencha o nome' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.contains('@') ? null : 'E-mail inválido',
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.length >= 10 ? null : 'Telefone inválido',
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.length >= 10 ? null : 'Telefone inválido',
                ),
              ],
            ),
          )),
    );
  }

  // Etapa 2: Upload de imagem
  Widget _stepTwo() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Aqui você pode implementar um picker de imagem
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
        Text(_imagePath == null
            ? 'Clique para adicionar uma imagem'
            : 'Imagem selecionada'),
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
