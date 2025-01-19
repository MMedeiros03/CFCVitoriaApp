import 'package:flutter/material.dart';
import '../Widgets/base_page_widget.dart';

class ServicosPage extends StatefulWidget{

  const ServicosPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicosPageState();

}

class ServicosPageState extends State<ServicosPage> {

  List<String> items = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"];

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
        child:
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: alturaTela * 0.2,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final stackHeight = constraints.maxHeight * 0.75; // 75% para o Stack
                        final containerHeight = constraints.maxHeight * 0.25; // 25% para o Container inferior

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                "assets/image/escolar.png",
                                height: stackHeight,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              height: containerHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Nome do curso"),
                                  ElevatedButton(
                                    onPressed: () {
                                    },
                                    child: Text("Saiba mais"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
        );
  }

}