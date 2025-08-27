import 'dart:io';
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
}
