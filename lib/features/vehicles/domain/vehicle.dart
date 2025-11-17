class Vehicle {
  String id;
  String donoID;
  String modelo;
  String placa;
  String marca;
  String ano;
  String tipoCombustivel;

  static const List<String> tiposCombustivel = [
    'Gasolina',
    'Gasolina aditivada',
    'Etanol',
    'Diesel',
    'Diesel S10',
    'Flex (Gasolina/Etanol)',
  ];

  Vehicle({
    required this.id,
    required this.donoID,
    required this.modelo,
    required this.placa,
    required this.marca,
    required this.ano,
    required this.tipoCombustivel,
  });

  Vehicle.fromMap(Map<String, dynamic> map, String idDoc)
      : id = idDoc,
        donoID = map['donoID'],
        modelo = map['modelo'],
        placa = map['placa'],
        marca = map['marca'],
        ano = map['ano'],
        tipoCombustivel = map['tipoCombustivel'];

  Map<String, dynamic> toMap() {
    return {
      'donoID': donoID,
      'modelo': modelo,
      'placa': placa,
      'marca': marca,
      'ano': ano,
      'tipoCombustivel': tipoCombustivel,
    };
  }
}
