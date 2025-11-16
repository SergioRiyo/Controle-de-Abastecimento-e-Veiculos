import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:controle_de_abastecimento/features/vehicles/application/vehicle_controller.dart';
import 'package:controle_de_abastecimento/features/vehicles/presentation/pages/vehicle_form_page.dart';

class VehiclesListPage extends StatefulWidget {
  const VehiclesListPage({super.key});

  @override
  State<VehiclesListPage> createState() => _VehiclesListPageState();
}

class _VehiclesListPageState extends State<VehiclesListPage> {
  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      Future.microtask(() {
        context.read<VehicleController>().startListening(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VehicleController>();

    Widget body;

    if (controller.isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (controller.errorMessage != null) {
      body = Center(
        child: Text(
          'Erro ao carregar veículos:\n${controller.errorMessage}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      );
    } else if (controller.vehicles.isEmpty) {
      body = const Center(child: Text("Nenhum veículo cadastrado."));
    } else {
      body = ListView.builder(
        itemCount: controller.vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = controller.vehicles[index];

          return ListTile(
            title: Text(vehicle.modelo),
            subtitle: Text('${vehicle.marca} • ${vehicle.placa}'),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VehicleFormPage(vehicle: vehicle),
                ),
              );
            },

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VehicleFormPage(vehicle: vehicle),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Excluir veículo'),
                        content: Text(
                          'Tem certeza que deseja excluir o veículo "${vehicle.modelo}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Excluir'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      try {
                        await context
                            .read<VehicleController>()
                            .deleteVehicle(vehicle.id);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Veículo excluído'),
                          ),
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao excluir: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Veículos")),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/vehicle_form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
