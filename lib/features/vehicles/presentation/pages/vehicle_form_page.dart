import 'package:controle_de_abastecimento/features/vehicles/application/vehicle_controller.dart';
import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleFormPage extends StatefulWidget {
  final Vehicle? vehicle;

  const VehicleFormPage({super.key, this.vehicle});

  @override
  State<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _modeloController = TextEditingController();
  final _placaController = TextEditingController();
  final _marcaController = TextEditingController();
  final _anoController = TextEditingController();

  String? _selectedCombustivel;

  bool get isEditing => widget.vehicle != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final v = widget.vehicle!;
      _modeloController.text = v.modelo;
      _placaController.text = v.placa;
      _marcaController.text = v.marca;
      _anoController.text = v.ano;
      _selectedCombustivel = v.tipoCombustivel;
    }
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _placaController.dispose();
    _marcaController.dispose();
    _anoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleController = context.read<VehicleController>();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar veículo' : 'Novo veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o modelo' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _marcaController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe a marca' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _placaController,
                  decoration: const InputDecoration(labelText: 'Placa'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe a placa' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _anoController,
                  decoration: const InputDecoration(labelText: 'Ano'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o ano' : null,
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedCombustivel,
                  items: Vehicle.tiposCombustivel
                      .map(
                        (tipo) => DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCombustivel = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tipo de combustível',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Selecione o tipo de combustível'
                          : null,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    final tipoCombustivel = _selectedCombustivel!;

                    if (isEditing) {
                      final v = widget.vehicle!;
                      final atualizado = Vehicle(
                        id: v.id,
                        donoID: v.donoID,
                        modelo: _modeloController.text,
                        placa: _placaController.text,
                        marca: _marcaController.text,
                        ano: _anoController.text,
                        tipoCombustivel: tipoCombustivel,
                      );
                      await vehicleController.updateVehicle(atualizado);
                    } else {
                      final novo = Vehicle(
                        id: '',
                        donoID: uid,
                        modelo: _modeloController.text,
                        placa: _placaController.text,
                        marca: _marcaController.text,
                        ano: _anoController.text,
                        tipoCombustivel: tipoCombustivel,
                      );
                      await vehicleController.addVehicle(novo);
                    }

                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                  child: Text(isEditing ? 'Salvar alterações' : 'Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
