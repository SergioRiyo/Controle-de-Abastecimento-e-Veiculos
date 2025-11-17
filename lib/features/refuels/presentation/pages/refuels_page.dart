import 'package:controle_de_abastecimento/features/refuels/application/refuel_controller.dart';
import 'package:controle_de_abastecimento/features/refuels/presentation/pages/refuel_form_page.dart';
import 'package:controle_de_abastecimento/features/vehicles/application/vehicle_controller.dart';
import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefuelsPage extends StatefulWidget {
  const RefuelsPage({super.key});

  @override
  State<RefuelsPage> createState() => _RefuelsPageState();
}

class _RefuelsPageState extends State<RefuelsPage> {
  Vehicle? selectedVehicle;

  @override
  Widget build(BuildContext context) {
    final vehicleController = context.watch<VehicleController>();
    final refuelController = context.watch<RefuelController>();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final vehicles = vehicleController.vehicles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Vehicle>(
              value: selectedVehicle,
              items: vehicles.map((v) {
                return DropdownMenuItem<Vehicle>(
                  value: v,
                  child: Text('${v.modelo} • ${v.placa}'),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  selectedVehicle = v;
                });
                if (v != null) {
                  context.read<RefuelController>().startListening(
                        ownerId: uid,
                        veiculoId: v.id,
                      );
                }
              },
              decoration: const InputDecoration(
                labelText: 'Selecione um veículo',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: _buildRefuelsContent(refuelController),
            ),
          ],
        ),
      ),

      floatingActionButton: selectedVehicle == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RefuelFormPage(
                      vehicle: selectedVehicle!,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildRefuelsContent(RefuelController c) {
    if (selectedVehicle == null) {
      return const Center(
        child: Text('Selecione um veículo para ver os abastecimentos.'),
      );
    }

    if (c.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (c.errorMessage != null) {
      return Center(
        child: Text(
          'Erro ao carregar abastecimentos:\n${c.errorMessage}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (c.refuels.isEmpty) {
      return const Center(child: Text('Nenhum abastecimento cadastrado.'));
    }

    return ListView.builder(
      itemCount: c.refuels.length,
      itemBuilder: (context, index) {
        final r = c.refuels[index];

        return ListTile(
          title: Text(
            '${r.quantidadeLitros.toStringAsFixed(1)} L  •  R\$ ${r.valorPago.toStringAsFixed(2)}',
          ),
          subtitle: Text(
            'Km: ${r.quilometragem.toStringAsFixed(0)}  •  ${r.tipoCombustivel}',
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RefuelFormPage(
                  vehicle: selectedVehicle!,
                  refuel: r,
                ),
              ),
            );
          },

          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await context.read<RefuelController>().deleteRefuel(r.id);
            },
          ),
        );
      },
    );
  }
}
