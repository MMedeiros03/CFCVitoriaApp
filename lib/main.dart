import 'package:cfc_vitoria_app/Utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: Locale("pt-BR"),
        debugShowCheckedModeBanner: false,
        title: 'Getx Rotas e Animações',
        initialRoute: '/home',
        getPages: Routes.getRoutes());
  }
}
