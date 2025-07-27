import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseStorage {
  final String caminhoImagensDocumentos = "DocumentosAlunos";

  final supabase = Supabase.instance.client;

  Future<String?> uploadImagem({
    required File imagem,
    required int alunoId,
  }) async {
    try {
      await autenticar();

      final fileBytes = await imagem.readAsBytes();
      final contentType = lookupMimeType(imagem.path);

      final String nomeArquivo = p.basename(imagem.path);
      final String caminhoDestino =
          "$caminhoImagensDocumentos/$alunoId/$nomeArquivo";

      final response = await supabase.storage
          .from('cfcvitoriaapp')
          .uploadBinary(caminhoDestino, fileBytes,
              fileOptions: FileOptions(
                upsert: true,
                contentType: contentType,
              ));

      if (response.isNotEmpty) {
        final imageUrl =
            supabase.storage.from('cfcvitoriaapp').getPublicUrl(caminhoDestino);

        return imageUrl;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future autenticar() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      return;
    } else {
      var supabaseUsuario = dotenv.env['SUPABASE_USER']!;
      var supabasePassword = dotenv.env['SUPABASE_PASSWORD']!;

      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: supabaseUsuario,
        password: supabasePassword,
      );

      if (response.user == null) {
        throw Exception("Erro ao autenticar no supabase.");
      }
    }
  }
}
