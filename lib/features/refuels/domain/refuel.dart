import 'package:cloud_firestore/cloud_firestore.dart';

class Refuel {
  String id;
  String donoID;
  String veiculoId;
  DateTime data;
  double quantidadeLitros;
  double valorPago;
  double quilometragem;
  String tipoCombustivel;
  double consumo;
  String observacao;

  Refuel({
    required this.id,
    required this.donoID,
    required this.veiculoId,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.consumo,
    required this.observacao,
  });

  Refuel.fromMap(Map<String, dynamic> map, String idDoc)
      : id = idDoc,
        donoID = map['donoID'],
        veiculoId = map['veiculoId'],
        data = (map['data'] as Timestamp).toDate(),
        quantidadeLitros = (map['quantidadeLitros'] as num).toDouble(),
        valorPago = (map['valorPago'] as num).toDouble(),
        quilometragem = (map['quilometragem'] as num).toDouble(),
        tipoCombustivel = map['tipoCombustivel'],
        consumo = (map['consumo'] as num).toDouble(),
        observacao = map['observacao'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'donoID': donoID,
      'veiculoId': veiculoId,
      'data': data,
      'quantidadeLitros': quantidadeLitros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
      'tipoCombustivel': tipoCombustivel,
      'consumo': consumo,
      'observacao': observacao,
    };
  }
}
