import 'dart:convert';

import 'package:cfc_vitoria_app/Dto/Request/Agendamento/agendamento_dto.dart';
import 'package:cfc_vitoria_app/Dto/Response/Agendamento/agendamento_rdto.dart';
import 'package:cfc_vitoria_app/Services/api_base_service.dart';

class AgendamentoService extends ApiServiceBase {
  Future<List<AgendamentoRDTO>> getAll() async {
    try {
      final response = await get('/Agendamento', autoriza: true);
      var responseJson = json.decode(response.body);
      return List.generate(responseJson.length, (i) {
        return AgendamentoRDTO.fromJson(responseJson[i]);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DateTime>> getHorariosDisponiveis(
      DateTime dataHoraSelecionado) async {
    try {
      dataHoraSelecionado = DateTime.now();

      final response = await get(
          '/Agendamento/ObterHorariosDisponiveis?dataHoraAgendamento=$dataHoraSelecionado',
          autoriza: true);
      var responseJson = json.decode(response.body);

      return (responseJson as List)
          .map((item) => DateTime.parse(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future createAgendamento(AgendamentoDTO novoAgendamento) async {
    try {
      await post('/Agendamento', novoAgendamento.toJson(), autoriza: true);
    } catch (e) {
      rethrow;
    }
  }
}
