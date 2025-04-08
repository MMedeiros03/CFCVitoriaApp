import 'package:cfc_vitoria_app/Dto/Request/Aluno/aluno_dto.dart';
import 'package:cfc_vitoria_app/Dto/Request/Endereco/endereco_dto.dart';
import 'package:cfc_vitoria_app/Services/aluno_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_button_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_snackbar_widget.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroAlunoPage extends StatefulWidget {
  const CadastroAlunoPage({super.key});

  @override
  State<StatefulWidget> createState() => CadastroAlunoPageState();
}

class CadastroAlunoPageState extends State<CadastroAlunoPage> {
  final String? mensagem = Get.arguments as String?;

  bool carregando = false;

  int _currentStep = 0;

  final _formKeyAluno = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();

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
        await service.cadastrarAluno(AlunoDTO(
            nome: _nomeController.value.text,
            email: _emailController.value.text,
            telefone: _telefoneController.value.text,
            cpf: _cpfController.value.text,
            dataNascimento: DateTime.now(),
            endereco: EnderecoDTO(
                cep: _cepController.value.text,
                rua: _ruaController.value.text,
                numero: _numeroCasaController.value.text,
                bairro: _bairroController.value.text,
                cidade: _cidadeController.value.text,
                estado: _estadoController.value.text)));

        Get.offNamed("/login");
      } else {
        BaseSnackbar.exibirNotificacao("Erro!",
            "Preencha todos os campos para realizar seu cadastro!", false);
      }

      setState(() {
        carregando = false;
      });
    } catch (ex) {
      BaseSnackbar.exibirNotificacao(
          "Erro!", "Houve um erro ao tentar fazer seu cadastro!", false);

      setState(() {
        carregando = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF0733D),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: alturaTela),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: alturaTela * 0.10,
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
                      child: carregando
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 40,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BaseText(
                                        text: _currentStep == 0
                                            ? "Informe seus dados"
                                            : "Informe seu Endereço",
                                        size: 20,
                                        color: Colors.black),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildStepIndicator(0),
                                    _buildStepIndicator(1),
                                  ],
                                ),
                                Expanded(
                                  child: IndexedStack(
                                    index: _currentStep,
                                    children: [
                                      _stepOne(),
                                      _stepTwo(),
                                    ],
                                  ),
                                ),
                                BaseButton(
                                  heigth: 50,
                                  width: larguraTela * 0.4,
                                  colorFont: Colors.black,
                                  backgroundColor: Color(0xFFF0733D),
                                  onPressed: () {
                                    if (_currentStep == 0 &&
                                        _formKeyAluno.currentState!
                                            .validate()) {
                                      setState(() {
                                        _currentStep = _currentStep + 1;
                                      });
                                    } else if (_currentStep == 1) {
                                      if (_formKeyEndereco.currentState!
                                          .validate()) {
                                        createAluno();
                                      }
                                    }
                                  },
                                  text: _currentStep != 1
                                      ? 'Próximo'
                                      : 'Finalizar',
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
            validator: (value) =>
                value!.isEmpty ? 'Preencha o campo Email' : null,
          ),
          SizedBox(height: 10),
          TextFormField(
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
            validator: (value) =>
                value!.isEmpty ? 'Preencha o campo Telefone' : null,
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
            style:
                TextStyle(color: Colors.black, fontFamily: "Libre Baskerville"),
            controller: _cepController,
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
