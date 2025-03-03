import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/base_text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  int currentStep = 1;
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF0733D),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: alturaTela),
            child: IntrinsicHeight(
              // Permite que o Column cresça corretamente
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: alturaTela * 0.35,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Lottie.asset(
                        width: larguraTela * 0.9,
                        height: larguraTela * 0.6,
                        repeat: true,
                        frameRate: FrameRate(90),
                        "assets/animations/AboutAnimation.json",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                        color: Color(0xFFE8E8E8),
                      ),
                      width: larguraTela,
                      padding: EdgeInsets.all(35),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          BaseText(
                              text: "Login", size: 25, color: Colors.black),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Colors.black38,
                                        fontFamily: "Libre Baskerville"),
                                    labelText: 'Nome',
                                    prefixIcon: Icon(Icons.person, size: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFFF0733D)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFFF0733D)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Color(0xFFF0733D), width: 2),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value!.isEmpty ? 'Preencha o nome' : null,
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Colors.black38,
                                        fontFamily: "Libre Baskerville"),
                                    labelText: 'Senha',
                                    prefixIcon: Icon(Icons.lock, size: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFFF0733D)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFFF0733D)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Color(0xFFF0733D), width: 2),
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Preencha a senha'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: Colors.black12,
                                    checkColor: Colors.green,
                                    value: _isChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _isChecked = newValue!;
                                      });
                                    },
                                  ),
                                  BaseText(
                                      bold: false,
                                      text: "Lembrar senha",
                                      size: 12,
                                      color: Colors.black),
                                ],
                              ),
                              BaseText(
                                  onClick: () {},
                                  bold: false,
                                  text: "Esqueceu sua senha?",
                                  size: 11,
                                  color: Colors.black)
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: BaseButton(
                              heigth: 50,
                              widget: 20,
                              onPressed: () {},
                              text: "Entrar",
                              fontSize: 14,
                              colorFont: Colors.black,
                              backgroundColor: Color(0xFFF0733D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
