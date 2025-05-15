import 'package:cfc_vitoria_app/Dto/Response/Servico/servico_rdto.dart';
import 'package:cfc_vitoria_app/Services/servico_service.dart';
import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:cfc_vitoria_app/Widgets/service_card_widget.dart';
import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicosPageState();
}

class ServicosPageState extends State<ServicosPage>
    with SingleTickerProviderStateMixin {
  List<ServicoRDTO> servicos = [];
  bool carregando = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _inicializar();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _inicializar() async {
    try {
      var service = ServicoService();

      var servicosApi = await service.getAll();

      setState(() {
        servicos = servicosApi;
        carregando = false;
      });
    } catch (ex) {
      setState(() {
        servicos = [];
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return BasePage(
      child: carregando
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                BaseText(
                  text: " ${servicos.length} Serviços Encontrados",
                  size: 13,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: servicos.length,
                    itemBuilder: (context, index) {
                      ServicoRDTO servico = servicos[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: SizedBox(
                          width: larguraTela,
                          height: alturaTela * 0.24,
                          child: ServiceCard(
                            controller: _controller,
                            servico: servico,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
