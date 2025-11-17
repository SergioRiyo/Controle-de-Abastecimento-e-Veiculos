import 'package:controle_de_abastecimento/core/routing/auth_gate.dart';
import 'package:controle_de_abastecimento/features/vehicles/presentation/pages/vehicle_form_page.dart';
import 'package:controle_de_abastecimento/features/vehicles/presentation/pages/vehicles_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/application/auth_controller.dart';
import 'features/auth/infrastructure/auth_service.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/home_page.dart';
import 'features/vehicles/application/vehicle_controller.dart';
import 'features/vehicles/infrastructure/vehicle_service.dart';
import 'features/refuels/infrastructure/refuel_service.dart';
import 'features/refuels/application/refuel_controller.dart';

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
        Provider<VehicleService>(create: (_) => VehicleService()),
        ChangeNotifierProvider<VehicleController>(
          create: (context) =>
              VehicleController(context.read<VehicleService>()),
        ),
        Provider<RefuelService>(create: (_) => RefuelService()),
        ChangeNotifierProvider<RefuelController>(
          create: (context) => RefuelController(context.read<RefuelService>()),
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
          '/vehicles': (_) => const VehiclesListPage(),
          '/vehicle_form': (_) => const VehicleFormPage(),
          '/refuels': (_) => const VehiclesListPage(),
        },
      ),
    );
  }
}
