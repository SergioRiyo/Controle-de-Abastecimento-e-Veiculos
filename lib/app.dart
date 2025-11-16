import 'package:controle_de_abastecimento/core/routing/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/application/auth_controller.dart';
import 'features/auth/infrastructure/auth_service.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(context.read<AuthService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Controle Abastecimento App',
        home: const AuthGate(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
