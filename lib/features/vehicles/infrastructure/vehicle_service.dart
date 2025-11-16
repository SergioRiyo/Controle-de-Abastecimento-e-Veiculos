import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _vehiclesCollection =>
      _db.collection('vehicles');

  Stream<List<Vehicle>> watchUserVehicles(String ownerId) {
    return _vehiclesCollection
        .where('donoID', isEqualTo: ownerId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Vehicle.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await _vehiclesCollection.add(vehicle.toMap());
  }
  Future<void> updateVehicle(Vehicle vehicle) async{
    await _vehiclesCollection.doc(vehicle.id).update(vehicle.toMap());
  }
  Future<void> deleteVehicle(String id){
    return _vehiclesCollection.doc(id).delete();
  }
}