import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import '../Widgets/base_page_widget.dart';

class SemInternetPage extends StatefulWidget{

  const SemInternetPage({super.key});

  @override
  State<StatefulWidget> createState() => SemInternetPageState();

}

class SemInternetPageState extends State<SemInternetPage> {
  @override
  Widget build(BuildContext context) {

    final alturaTela = MediaQuery.of(context).size.height;


    return BasePage(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: alturaTela * -0.08,
            children: [
              Lottie.asset(
                frameRate: FrameRate(90),
                "assets/animations/AlertAnimation.json",
                fit: BoxFit.fill,
              ),
              Text("Ops! Parece que você está sem conexão com a internet. Verifique sua conexão com a internet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
              )
            ],
          )
    );
  }

}