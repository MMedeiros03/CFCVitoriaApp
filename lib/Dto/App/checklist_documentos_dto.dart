import 'dart:io';

import 'package:cfc_vitoria_app/Utils/enums.dart';

class ChecklistDocumentoDto {
  TipoDocumento tipoDocumento;
  File? documento;

  ChecklistDocumentoDto({
    required this.tipoDocumento,
    this.documento,
  });
}
