import 'package:flutter/foundation.dart';
import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:controle_de_abastecimento/features/vehicles/infrastructure/vehicle_service.dart';

class VehicleController extends ChangeNotifier {
  final VehicleService _service;

  List<Vehicle> vehicles = [];
  bool isLoading = false;
  String? errorMessage;

  VehicleController(this._service);

  void startListening(String ownerId) {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    _service.watchUserVehicles(ownerId).listen(
      (vehicleList) {
        vehicles = vehicleList;
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

  Future<void> addVehicle(Vehicle vehicle) async {
    await _service.addVehicle(vehicle);
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await _service.updateVehicle(vehicle);
  }

  Future<void> deleteVehicle(String id) async {
    await _service.deleteVehicle(id);
  }
}
