import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/base_page_widget.dart';

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  State<StatefulWidget> createState() => ServicosPageState();
}

class ServicosPageState extends State<ServicosPage> {
  List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16"
  ];

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;

    return BasePage(
      child: ListView.builder(
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
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Container(
                                width: constraints.maxWidth * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Nome do servico"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.toNamed("/servico");
                                              },
                                              child: Text("Saiba mais"))
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    })),
              ));
        },
      ),
    );
  }
}
