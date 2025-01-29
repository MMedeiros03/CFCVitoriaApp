import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Widgets/base_page_widget.dart';

class AgendamentosPage extends StatefulWidget{

  const AgendamentosPage({super.key});

  @override
  State<StatefulWidget> createState() => AgendamentosPageState();

}

class AgendamentosPageState extends State<AgendamentosPage> {

  List<int> items = [1,2,3,4,5,6];

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child: Column(
          children: [
            ListView.builder(
              itemCount: items.length, // Número de itens na lista
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("$items[index]"), // Primeira letra do item
                  ),
                  title: Text("$items[index]"), // Nome do item
                  subtitle: Text('Descrição do ${items[index]}'),
                  onTap: () {
                    // Ação ao clicar no item
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Você clicou no ${items[index]}')),
                    );
                  },
                );
              },
            ),
          ],
        )
    );
  }

}