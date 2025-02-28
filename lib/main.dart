import 'package:cfc_vitoria_app/Utils/loading.dart';
import 'package:cfc_vitoria_app/Utils/routes.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR', null);
  Get.put(LoadingController());
  String initialRoute = await setInitPage();
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

Future<String> setInitPage() async {
  if (await StorageService.getVisualizedTutorial()) {
    return "/home";
  }
  return "/tutorial";
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale("pt-BR"),
      debugShowCheckedModeBanner: false,
      title: 'Getx Rotas e Animações',
      initialRoute: initialRoute,
      getPages: Routes.getRoutes(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            GlobalLoading(),
          ],
        );
      },
    );
  }
}
