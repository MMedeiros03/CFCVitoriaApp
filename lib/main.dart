import 'package:cfc_vitoria_app/Utils/routes.dart';
import 'package:cfc_vitoria_app/Utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR', null);
  String initialRoute = await setInitPage();
  runApp(MyApp(
    initialRoute: initialRoute,
  ));

  var supabaseUrl = dotenv.env['SUPABASE_URL']!;
  var supabasekey = dotenv.env['SUPABASE_KEY']!;

  await Supabase.initialize(url: supabaseUrl, anonKey: supabasekey);
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
      debugShowCheckedModeBanner: true,
      title: 'Getx Rotas e Animações',
      initialRoute: initialRoute,
      getPages: Routes.getRoutes(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
