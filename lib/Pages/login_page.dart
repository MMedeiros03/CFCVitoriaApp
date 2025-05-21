import 'package:cfc_vitoria_app/Dto/Request/Login/login_dto.dart';
import 'package:cfc_vitoria_app/Services/login_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/base_text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final String? mensagem = Get.arguments as String?;
  bool _carregando = false;
  int currentStep = 1;
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: "13425212931");
  final TextEditingController _emailController =
      TextEditingController(text: "13425212931");

  Future login() async {
    setState(() {
      _carregando = true;
    });

    LoginService service = LoginService();

    await service.login(
        LoginDTO(login: _nameController.text, password: _nameController.text));

    setState(() {
      _carregando = true;
    });

    Get.offNamed("/home");
  }

  Future redirectCadastro() async {
    Get.toNamed("/cadastro-aluno");
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _inicializar();
    });
  }

  _inicializar() async {
    if (mensagem != null) {
      BaseSnackbar.exibirNotificacao("", mensagem ?? "", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.offAllNamed("/home");
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF0733D),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(children: [
                        SizedBox(
                          height: alturaTela * 0.4,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Lottie.asset(
                              "assets/animations/AboutAnimation.json",
                              width: larguraTela * 0.9,
                              height: larguraTela * 0.6,
                              repeat: true,
                              frameRate: FrameRate(90),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: larguraTela,
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                              ),
                              color: Color(0xFFE8E8E8),
                            ),
                            child: _carregando
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BaseText(
                                          text: "Login",
                                          size: 25,
                                          color: Colors.black),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      "Libre Baskerville"),
                                              controller: _nameController,
                                              decoration: _buildInputDecoration(
                                                  "Nome", Icons.person),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Preencha o nome'
                                                      : null,
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: _emailController,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      "Libre Baskerville"),
                                              decoration: _buildInputDecoration(
                                                  "Senha", Icons.lock),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Preencha a senha'
                                                      : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: BaseButton(
                                          heigth: 50,
                                          widget: 20,
                                          onPressed: login,
                                          text: "Entrar",
                                          fontSize: 14,
                                          colorFont: Colors.black,
                                          backgroundColor: Color(0xFFF0733D),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: BaseButton(
                                          heigth: 50,
                                          widget: 20,
                                          onPressed: redirectCadastro,
                                          text: "Cadastre-se",
                                          fontSize: 14,
                                          colorFont: Colors.black,
                                          backgroundColor: Color(0xFFF0733D),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ]),
                    )));
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelStyle:
          TextStyle(color: Colors.black38, fontFamily: "Libre Baskerville"),
      labelText: label,
      prefixIcon: Icon(icon, size: 15),
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
    );
  }
}
