import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImagem({
    required File imagem,
    required String caminhoDestino,
  }) async {
    try {
      final Reference storageRef = _storage.ref().child(caminhoDestino);
      final UploadTask uploadTask = storageRef.putFile(imagem);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }
}
