import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:controle_de_abastecimento/features/vehicles/application/vehicle_controller.dart';

class VehicleFormPage extends StatefulWidget {
  final Vehicle? vehicle;

  const VehicleFormPage({super.key, this.vehicle});

  @override
  State<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  final formKey = GlobalKey<FormState>();

  final modeloController = TextEditingController();
  final marcaController = TextEditingController();
  final placaController = TextEditingController();
  final anoController = TextEditingController();
  final combustivelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.vehicle != null) {
      modeloController.text = widget.vehicle!.modelo;
      marcaController.text = widget.vehicle!.marca;
      placaController.text = widget.vehicle!.placa;
      anoController.text = widget.vehicle!.ano;
      combustivelController.text = widget.vehicle!.tipoCombustivel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<VehicleController>();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final isEditing = widget.vehicle != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar veículo" : "Novo veículo"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: modeloController,
                decoration: const InputDecoration(labelText: "Modelo"),
                validator: (v) => v == null || v.isEmpty ? "Informe o modelo" : null,
              ),

              TextFormField(
                controller: marcaController,
                decoration: const InputDecoration(labelText: "Marca"),
              ),

              TextFormField(
                controller: placaController,
                decoration: const InputDecoration(labelText: "Placa"),
                validator: (v) => v == null || v.isEmpty ? "Informe a placa" : null,
              ),

              TextFormField(
                controller: anoController,
                decoration: const InputDecoration(labelText: "Ano"),
              ),

              TextFormField(
                controller: combustivelController,
                decoration: const InputDecoration(labelText: "Combustível"),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  if (!isEditing) {
                    final novo = Vehicle(
                      id: "",
                      donoID: uid,
                      modelo: modeloController.text,
                      marca: marcaController.text,
                      placa: placaController.text,
                      ano: anoController.text,
                      tipoCombustivel: combustivelController.text,
                    );
                    await controller.addVehicle(novo);
                  }
                  else {
                    final atualizado = Vehicle(
                      id: widget.vehicle!.id,
                      donoID: uid,
                      modelo: modeloController.text,
                      marca: marcaController.text,
                      placa: placaController.text,
                      ano: anoController.text,
                      tipoCombustivel: combustivelController.text,
                    );

                    await controller.updateVehicle(atualizado);
                  }

                  if (mounted) Navigator.pop(context);
                },
                child: Text(isEditing ? "Salvar alterações" : "Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
