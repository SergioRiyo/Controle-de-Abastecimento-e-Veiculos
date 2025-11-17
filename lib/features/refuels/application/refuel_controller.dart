import 'package:flutter/foundation.dart';
import 'package:controle_de_abastecimento/features/refuels/domain/refuel.dart';
import 'package:controle_de_abastecimento/features/refuels/infrastructure/refuel_service.dart';

class RefuelController extends ChangeNotifier {
  final RefuelService _service;

  List<Refuel> refuels = [];
  bool isLoading = false;
  String? errorMessage;

  RefuelController(this._service);

  void startListening({
    required String ownerId,
    required String veiculoId,
  }) {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    _service.watchRefuelsByVehicle(ownerId: ownerId, veiculoId: veiculoId).listen(
      (list) {
        refuels = list;
        isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        errorMessage = error.toString();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> addRefuel(Refuel refuel) async {
    await _service.addRefuel(refuel);
  }

  Future<void> updateRefuel(Refuel refuel) async {
    await _service.updateRefuel(refuel);
  }

  Future<void> deleteRefuel(String id) async {
    await _service.deleteRefuel(id);
  }
}
