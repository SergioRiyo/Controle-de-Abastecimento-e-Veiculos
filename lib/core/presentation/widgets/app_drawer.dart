import 'package:controle_de_abastecimento/core/routing/auth_gate.dart';
import 'package:controle_de_abastecimento/features/auth/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final auth = context.read<AuthController>();

    return Drawer(
      backgroundColor: colors.surface,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.primary, colors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'AbastX',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          _DrawerItem(
            icon: Icons.home,
            label: 'Início',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          _DrawerItem(
            icon: Icons.directions_car,
            label: 'Veículos',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/vehicles');
            },
          ),
          _DrawerItem(
            icon: Icons.local_gas_station,
            label: 'Abastecimentos',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/refuels');
            },
          ),

          const Spacer(),
          const Divider(height: 1),
          _DrawerItem(
            icon: Icons.logout,
            label: 'Sair',
            color: colors.error,
            onTap: () async {
              Navigator.pop(context); 
              await auth.signOut();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthGate()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: color ?? colors.secondary),
      title: Text(label),
      onTap: onTap,
    );
  }
}
