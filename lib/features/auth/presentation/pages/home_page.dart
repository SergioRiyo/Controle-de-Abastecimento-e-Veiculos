import 'package:controle_de_abastecimento/features/auth/application/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Tela Home")),
      body: Column(
        children: [
          Text('Bem-vindo, ${user?.email ?? 'usuário'}'),

          ElevatedButton(
            onPressed: () async {
              await context.read<AuthController>().signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text("Sair"),
          ),
        ],
      ),
    );
  }
}
