import 'package:cfc_vitoria_app/Dto/Request/Aluno/aluno_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Endereco/endereco_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Login/login_dto.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Services/cep_service.dart';
import 'package:cfc_vitoria_app/Services/login_service.dart';
import 'package:cfc_vitoria_app/Utils/utils.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroAlunoPage extends StatefulWidget {
  const CadastroAlunoPage({super.key});

  @override
  State<StatefulWidget> createState() => CadastroAlunoPageState();
}

class CadastroAlunoPageState extends State<CadastroAlunoPage> {
  final String? mensagem = Get.arguments as String?;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeCpf = FocusNode();
  bool _cpfValido = false;
  bool carregando = false;
  int _currentStep = 0;
  final _formKeyAluno = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();

  final _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _dataFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _numeroCasaController = TextEditingController();

  Future createAluno() async {
    try {
      AlunoService service = AlunoService();

      setState(() {
        carregando = true;
      });

      if (_formKeyAluno.currentState!.validate() &&
          _formKeyEndereco.currentState!.validate()) {
        DateTime dataNascimento =
            DateFormat('dd/MM/yyyy').parse(_dataNascimentoController.text);

        await service.cadastrarAluno(AlunoDTO(
            nome: _nomeController.value.text,
            email: _emailController.value.text,
            telefone: _telefoneController.value.text,
            cpf: _cpfController.value.text,
            dataNascimento: dataNascimento,
            endereco: EnderecoDTO(
                cep: _cepController.value.text,
                rua: _ruaController.value.text,
                numero: _numeroCasaController.value.text,
                bairro: _bairroController.value.text,
                cidade: _cidadeController.value.text,
                estado: _estadoController.value.text)));

        BaseSnackbar.exibirNotificacao(
            "Sucesso!", "Cadastrado com sucesso!", true);

        login();
      } else {
        BaseSnackbar.exibirNotificacao("Erro!",
            "Preencha todos os campos para realizar seu cadastro!", false);
        setState(() {
          carregando = false;
        });
      }
    } catch (ex) {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "Houve um erro ao tentar fazer seu cadastro!", false);

      setState(() {
        carregando = false;
      });
    }
  }

  void validarCpf() {
    if (_cpfController.text == "") return;

    var cpfValido = Utils.validarCpf(_cpfController.text);

    setState(() {
      _cpfValido = cpfValido;
    });

    if (!cpfValido) {
      BaseSnackbar.exibirNotificacao("Erro!", "Informe um CPF válido", false);
      return;
    }
  }

  Future login() async {
    try {
      LoginService service = LoginService();
      var senha = Utils.cpfParaSenha(_cpfController.text);
      await service
          .login(LoginDTO(login: _cpfController.value.text, password: senha));
      setState(() {
        carregando = false;
      });
      Get.offNamed("/home");
    } catch (ex) {
      setState(() {
        carregando = false;
      });

      BaseSnackbar.exibirNotificacao(
          "Erro!",
          "Houve um erro durante o login. Revise suas credenciais e tente novamente!",
          false);

      Get.offNamed("/login");
    }
  }

  Future _buscarEnderecoPorCep() async {
    if ("" == _cepController.value.text) {
      _ruaController.text = "";
      _bairroController.text = "";
      _cidadeController.text = "";
      _estadoController.text = "";

      return;
    }

    setState(() {
      carregando = true;
    });

    var endereco =
        await CepService.buscarEnderecoPorCEP(_cepController.value.text);

    if (endereco != null) {
      _ruaController.text = endereco.logradouro;
      _bairroController.text = endereco.bairro;
      _cidadeController.text = endereco.localidade;
      _estadoController.text = endereco.uf;
    } else {
      _ruaController.text = "";
      _bairroController.text = "";
      _cidadeController.text = "";
      _estadoController.text = "";

      BaseSnackbar.exibirNotificacao(
          "Erro!",
          "Não foi possivel obter o endereço pelo CEP informado. Preencha manualmente!",
          false);
    }

    setState(() {
      carregando = false;
    });
  }

  Widget _buildStepIndicator(int step) {
    bool isSelected = _currentStep == step;

    return InkWell(
      onTap: () {
        if (_formKeyAluno.currentState!.validate()) {
          setState(() {
            _currentStep = step;
          });
        }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 5),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSelected ? 70 : 20,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xFFF0733D),
          borderRadius: BorderRadius.circular(isSelected ? 12 : 50),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _focusNodeCpf.addListener(() {
      if (!_focusNodeCpf.hasFocus) {
        validarCpf();
      }
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _buscarEnderecoPorCep();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNodeCpf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF0733D),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                          ),
                          color: Color(0xFFE8E8E8),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(35),
                        child: carregando
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10),
                                  Center(
                                    child: BaseText(
                                      text: _currentStep == 0
                                          ? "Informe seus dados"
                                          : "Informe seu Endereço",
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildStepIndicator(0),
                                      _buildStepIndicator(1),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  IndexedStack(
                                    index: _currentStep,
                                    children: [
                                      _stepOne(),
                                      _stepTwo(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  BaseButton(
                                    heigth: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    colorFont: Colors.black,
                                    backgroundColor: Color(0xFFF0733D),
                                    onPressed: _cpfValido
                                        ? () {
                                            if (_currentStep == 0 &&
                                                _formKeyAluno.currentState!
                                                    .validate()) {
                                              setState(() {
                                                _currentStep += 1;
                                              });
                                            } else if (_currentStep == 1) {
                                              if (_formKeyEndereco.currentState!
                                                  .validate()) {
                                                createAluno();
                                              }
                                            }
                                          }
                                        : null,
                                    text: _currentStep != 1
                                        ? 'Próximo'
                                        : 'Finalizar',
                                  ),
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _stepOne() {
    return Form(
      key: _formKeyAluno,
      child: Column(
        spacing: 5,
        children: [
          TextFormField(
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            controller: _nomeController,
            decoration: InputDecoration(
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
            validator: (value) =>
                value!.isEmpty ? 'Preencha o campo Nome' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            focusNode: _focusNodeCpf,
            inputFormatters: [_cpfFormatter],
            controller: _cpfController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'CPF',
              prefixIcon: Icon(Icons.assignment_ind, size: 15),
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
                value!.isEmpty ? 'Preencha o campo CPF' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _dataNascimentoController,
            inputFormatters: [_dataFormatter],
            keyboardType: TextInputType.number,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
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
                value!.isEmpty ? 'Preencha o campo Data de Nascimento' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Email',
              prefixIcon: Icon(Icons.mail, size: 15),
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Preencha o campo Email';
              }

              var ehValido = Utils.ehEmailValido(value);

              if (!ehValido) {
                return 'Email inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            inputFormatters: [_phoneMaskFormatter],
            controller: _telefoneController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Preencha o campo Telefone';
              }
              final telefoneRegex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
              if (!telefoneRegex.hasMatch(value)) {
                return 'Informe um número de telefone válido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _stepTwo() {
    return Form(
      key: _formKeyEndereco,
      child: Column(
        spacing: 5,
        children: [
          TextFormField(
            inputFormatters: [_cepMaskFormatter],
            focusNode: _focusNode,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            controller: _cepController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'CEP',
              prefixIcon: Icon(Icons.local_post_office, size: 15),
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
          ),
          SizedBox(height: 10),
          TextFormField(
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            controller: _ruaController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Rua',
              prefixIcon: Icon(Icons.location_on, size: 15),
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
                value!.isEmpty ? 'Preencha o campo Rua' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _numeroCasaController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'N.º',
              prefixIcon: Icon(Icons.pin, size: 15),
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
                value!.isEmpty ? 'Preencha o campo Número' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _bairroController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Bairro',
              prefixIcon: Icon(Icons.home_work, size: 15),
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
                value!.isEmpty ? 'Preencha o campo Bairro' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _cidadeController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Cidade',
              prefixIcon: Icon(Icons.location_city, size: 15),
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
                value!.isEmpty ? 'Preencha o campo Cidade' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _estadoController,
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.black38, fontFamily: "Libre Baskerville"),
              labelText: 'Estado',
              prefixIcon: Icon(Icons.map, size: 15),
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
                value!.isEmpty ? 'Preencha o campo Estado' : null,
          ),
        ],
      ),
    );
  }
}
