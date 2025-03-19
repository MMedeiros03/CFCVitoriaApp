import 'dart:io';

import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final _formKey2 = GlobalKey<FormState>();

  // Controladores para capturar os dados do formulário
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdaydate = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future _inicializar() async {
    var tokenValido = await Utils.validaToken();

    if (!tokenValido) {
      Get.toNamed("/login",
          arguments: "Você precisa fazer o login para visualizar seus dados");
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: SingleChildScrollView(
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

            if (_currentStep > 0)
              BaseButton(
                heigth: 50,
                width: larguraTela * 0.4,
                backgroundColor: Color(0xFFF0733D),
                text: "Salvar",
                colorFont: Colors.black,
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
              ),

            if (_currentStep == 0)
              BaseButton(
                heigth: 50,
                width: larguraTela * 0.4,
                colorFont: Colors.black,
                backgroundColor: Color(0xFFF0733D),
                onPressed: () {
                  if (_currentStep == 0) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _currentStep = 1;
                      });
                    }
                  } else {
                    print('Nome: ${_nameController.text}');
                    print('E-mail: ${_emailController.text}');
                    print('Telefone: ${_phoneController.text}');
                    print('Imagem: $_imagePath');
                  }
                },
                text: _currentStep == 0 ? 'Próximo' : 'Finalizar',
              ),
          ],
        ),
      ),
    );
  }

  Widget _stepOne() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 15,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Nome',
              prefixIcon: Icon(Icons.person, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) => value!.isEmpty ? 'Preencha o nome' : null,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha o número de telefone' : null,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Email',
              prefixIcon: Icon(Icons.email, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha o seu e-mail' : null,
          ),
          TextFormField(
            controller: _birthdaydate,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: const Color(0xFF970C02),
                  fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Data de Nascimento',
              prefixIcon: Icon(Icons.calendar_month, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha sua data de nascimento' : null,
          ),
        ],
      ),
    );
  }

  Widget _stepTwo() {
    return Form(
      key: _formKey2,
      child: Column(
        spacing: 15,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Rua',
              prefixIcon: Icon(Icons.person, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) => value!.isEmpty ? 'Preencha o nome' : null,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Numero',
              prefixIcon: Icon(Icons.phone, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha o número de telefone' : null,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Color(0xFF970C02), fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Bairro',
              prefixIcon: Icon(Icons.email, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha o seu e-mail' : null,
          ),
          TextFormField(
            controller: _birthdaydate,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: const Color(0xFF970C02),
                  fontFamily: "Libre Baskerville"),
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Cidade',
              prefixIcon: Icon(Icons.calendar_month, size: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF0733D), width: 2),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Preencha sua data de nascimento' : null,
          ),
        ],
      ),
    );
  }

  // Etapa 2: Upload de imagem
  // Widget _stepTwo() {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _imagePath = 'imagem_selecionada.png'; // Simulação
  //           });
  //         },
  //         child: Container(
  //           width: 150,
  //           height: 150,
  //           decoration: BoxDecoration(
  //             color: Colors.grey[300],
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: _imagePath == null
  //               ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey[700])
  //               : Image.asset(_imagePath!, fit: BoxFit.cover),
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       BaseText(
  //         size: 10,
  //         color: Colors.black,
  //         text: _imagePath == null
  //             ? 'Clique para adicionar uma imagem'
  //             : 'Imagem selecionada',
  //       ),
  //     ],
  //   );
  // }

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
