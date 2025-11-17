import 'package:controle_de_abastecimento/features/refuels/application/refuel_controller.dart';
import 'package:controle_de_abastecimento/features/refuels/domain/refuel.dart';
import 'package:controle_de_abastecimento/features/vehicles/domain/vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefuelFormPage extends StatefulWidget {
  final Vehicle vehicle;
  final Refuel? refuel;

  const RefuelFormPage({
    super.key,
    required this.vehicle,
    this.refuel,
  });

  @override
  State<RefuelFormPage> createState() => _RefuelFormPageState();
}

class _RefuelFormPageState extends State<RefuelFormPage> {
  final formKey = GlobalKey<FormState>();

  final litrosController = TextEditingController();
  final valorController = TextEditingController();
  final kmController = TextEditingController();
  final tipoCombustivelController = TextEditingController();
  final observacaoController = TextEditingController();
  DateTime dataAbastecimento = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.refuel != null) {
      final r = widget.refuel!;
      litrosController.text = r.quantidadeLitros.toString();
      valorController.text = r.valorPago.toString();
      kmController.text = r.quilometragem.toString();
      tipoCombustivelController.text = r.tipoCombustivel;
      observacaoController.text = r.observacao;
      dataAbastecimento = r.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RefuelController>();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final isEditing = widget.refuel != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Abastecimento' : 'Novo Abastecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Data (por simplicidade deixamos fixa, mas dá pra abrir datepicker)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data: ${dataAbastecimento.day}/${dataAbastecimento.month}/${dataAbastecimento.year}',
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: litrosController,
                  decoration: const InputDecoration(labelText: 'Quantidade de litros'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe os litros' : null,
                ),
                TextFormField(
                  controller: valorController,
                  decoration: const InputDecoration(labelText: 'Valor pago'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o valor' : null,
                ),
                TextFormField(
                  controller: kmController,
                  decoration:
                      const InputDecoration(labelText: 'Quilometragem (km)'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a quilometragem' : null,
                ),
                TextFormField(
                  controller: tipoCombustivelController,
                  decoration:
                      const InputDecoration(labelText: 'Tipo de combustível'),
                ),
                TextFormField(
                  controller: observacaoController,
                  decoration:
                      const InputDecoration(labelText: 'Observação'),
                  maxLines: 2,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;

                    final litros = double.parse(litrosController.text);
                    final valor = double.parse(valorController.text);
                    final km = double.parse(kmController.text);

                    // consumo simples: km / litros
                    final consumo = litros > 0 ? km / litros : 0.0;

                    if (isEditing) {
                      final r = widget.refuel!;
                      final atualizado = Refuel(
                        id: r.id,
                        donoID: uid,
                        veiculoId: widget.vehicle.id,
                        data: dataAbastecimento,
                        quantidadeLitros: litros,
                        valorPago: valor,
                        quilometragem: km,
                        tipoCombustivel: tipoCombustivelController.text,
                        consumo: consumo,
                        observacao: observacaoController.text,
                      );
                      await controller.updateRefuel(atualizado);
                    } else {
                      final novo = Refuel(
                        id: '',
                        donoID: uid,
                        veiculoId: widget.vehicle.id,
                        data: dataAbastecimento,
                        quantidadeLitros: litros,
                        valorPago: valor,
                        quilometragem: km,
                        tipoCombustivel: tipoCombustivelController.text,
                        consumo: consumo,
                        observacao: observacaoController.text,
                      );
                      await controller.addRefuel(novo);
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
