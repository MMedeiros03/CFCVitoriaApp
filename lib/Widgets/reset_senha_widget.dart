import 'package:cfc_vitoria_app/Dto/App/checklist_senha_dto.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

class ResetSenha extends StatefulWidget {
  const ResetSenha({super.key});

  @override
  State<ResetSenha> createState() => ResetSenhaState();
}

class ResetSenhaState extends State<ResetSenha> {
  bool carregando = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  bool _obscurePasswordNovaSenha = true;
  bool _obscurePasswordConfirma = true;
  bool _senhaValidada = false;

  ChecklistSenhaDto checklistSenhaDto = ChecklistSenhaDto(
    caracterEspecial: false,
    letraMaiuscula: false,
    letraMinuscula: false,
    minimoCaracteres: false,
    minimoNumero: false,
  );

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: BaseText(
          text: 'Redefinir Senha',
          size: 18,
          bold: true,
          alignText: true,
          color: Colors.black,
        ),
        content: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (carregando)
                const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              if (!carregando) ...[
                const BaseText(
                  text:
                      'Foi solicitada a redefinição da sua senha. Por favor, defina uma nova senha de acesso para sua conta.',
                  size: 15,
                  bold: false,
                  justifyText: true,
                  color: Colors.black,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          validarForcaNovaSenha(value);
                        },
                        controller: _novaSenhaController,
                        obscureText: _obscurePasswordNovaSenha,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Libre Baskerville",
                        ),
                        decoration: _buildInputDecoration(
                          "Senha",
                          Icons.lock,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePasswordNovaSenha
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePasswordNovaSenha =
                                    !_obscurePasswordNovaSenha;
                              });
                            },
                          ),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Preencha a senha'
                            : null,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          validaConfirmarSenha();
                        },
                        controller: _confirmaSenhaController,
                        obscureText: _obscurePasswordConfirma,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Libre Baskerville",
                        ),
                        decoration: _buildInputDecoration(
                          "Confirmar Senha",
                          Icons.lock,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePasswordConfirma
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePasswordConfirma =
                                    !_obscurePasswordConfirma;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          if (value != _novaSenhaController.text) {
                            return 'As senhas precisam ser iguais';
                          }
                          return null;
                        },
                      ),
                      Column(spacing: 8, children: [
                        Row(
                          spacing: 5,
                          children: [
                            checklistSenhaDto.minimoCaracteres
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                            BaseText(
                                bold: false,
                                text: "Mínimo de 8 caracteres",
                                size: 14,
                                color: Colors.black45)
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            checklistSenhaDto.letraMaiuscula
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                            BaseText(
                                bold: false,
                                text: "Pelo menos uma letra maiúscula",
                                size: 14,
                                color: Colors.black45)
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            checklistSenhaDto.letraMinuscula
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                            BaseText(
                                bold: false,
                                text: "Pelo menos uma letra minúscula",
                                size: 14,
                                color: Colors.black45)
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            checklistSenhaDto.minimoNumero
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                            BaseText(
                                bold: false,
                                text: "Pelo menos um número",
                                size: 14,
                                color: Colors.black45)
                          ],
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            checklistSenhaDto.caracterEspecial
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                            BaseText(
                                bold: false,
                                text: "Pelo menos um carácter especial",
                                size: 14,
                                color: Colors.black45)
                          ],
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          BaseButton(
              showButton: true,
              text: "Confirmar",
              colorFont: Colors.black,
              backgroundColor: Color(0xFFF0733D),
              onPressed: _senhaValidada
                  ? () {
                      confirmaResetSenha();
                    }
                  : null),
        ],
      );
    });
  }

  void validaConfirmarSenha() {
    if (checklistSenhaDto.minimoCaracteres == true &&
        checklistSenhaDto.caracterEspecial == true &&
        checklistSenhaDto.letraMaiuscula == true &&
        checklistSenhaDto.letraMinuscula == true &&
        _formKey.currentState!.validate() &&
        checklistSenhaDto.minimoNumero == true) {
      setState(() {
        _senhaValidada = true;
      });
    }
  }

  void validarForcaNovaSenha(String senha) {
    final regexLetraMinuscula = RegExp(r'^(?=.*[a-z])');
    final regexLetraMaiuscula = RegExp(r'^(?=.*[A-Z])');
    final regexMinimoNumero = RegExp(r'^(?=.*\d)');
    final regexCaracterEspecial = RegExp(r'^(?=.*[\W_])');

    setState(() {
      checklistSenhaDto.letraMinuscula = regexLetraMinuscula.hasMatch(senha);
      checklistSenhaDto.letraMaiuscula = regexLetraMaiuscula.hasMatch(senha);
      checklistSenhaDto.minimoNumero = regexMinimoNumero.hasMatch(senha);
      checklistSenhaDto.caracterEspecial =
          regexCaracterEspecial.hasMatch(senha);
      checklistSenhaDto.minimoCaracteres = senha.length >= 8;
    });
  }

  void confirmaResetSenha() async {
    setState(() {
      carregando = true;
    });

    if (_novaSenhaController.text.isEmpty &&
        _confirmaSenhaController.text.isEmpty) {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "Por favor informe uma nova senha.", false);

      return;
    }

    if (_novaSenhaController.text != _confirmaSenhaController.text) {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "As senhas devem ser iguais ", false);

      return;
    }

    try {
      await AlunoService().resetarSenhaAluno(_novaSenhaController.text);

      BaseSnackbar.exibirNotificacao(
          "Sucesso!", "Senha alterada com sucesso!", true);

      await StorageService.setSolicitouResetSenha(false);

      setState(() {
        carregando = false;
      });

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      BaseSnackbar.exibirNotificacao(
          "Erro!",
          "Não foi possivel redefinir a sua senha! Tente novamente mais tarde.",
          false);

      setState(() {
        carregando = false;
      });
    }
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
