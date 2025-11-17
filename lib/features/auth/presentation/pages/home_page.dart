import 'package:controle_de_abastecimento/features/refuels/presentation/pages/refuels_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controle_de_abastecimento/features/auth/application/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo!', style: TextStyle(fontSize: 20)),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vehicles');
              },
              child: const Text("Gerenciar Veículos"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthController>().signOut();
              },
              child: const Text("Sair"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RefuelsPage()),
                );
              },
              child: const Text('Abastecimentos'),
            ),
          ],
        ),
      ),
    );
  }
}
