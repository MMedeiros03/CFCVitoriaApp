import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final String caminhoImagensDocumentos = "DocumentosAlunos";

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImagem({
    required File imagem,
    required int alunoId,
  }) async {
    try {
      final String nomeArquivo = p.basename(imagem.path);
      final String caminhoDestino =
          "$caminhoImagensDocumentos/$alunoId/$nomeArquivo";

      final Reference storageRef = _storage.ref().child(caminhoDestino);
      final UploadTask uploadTask = storageRef.putFile(imagem);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
