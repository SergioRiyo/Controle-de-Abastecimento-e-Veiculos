import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_de_abastecimento/features/refuels/domain/refuel.dart';

class RefuelService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _refuelsCollection =>
      _db.collection('refuels');

  Stream<List<Refuel>> watchRefuelsByVehicle({
    required String ownerId,
    required String veiculoId,
  }) {
    return _refuelsCollection
        .where('donoID', isEqualTo: ownerId)
        .where('veiculoId', isEqualTo: veiculoId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Refuel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addRefuel(Refuel refuel) async {
    await _refuelsCollection.add(refuel.toMap());
  }

  Future<void> updateRefuel(Refuel refuel) async {
    await _refuelsCollection.doc(refuel.id).update(refuel.toMap());
  }

  Future<void> deleteRefuel(String id) async {
    await _refuelsCollection.doc(id).delete();
  }
}
