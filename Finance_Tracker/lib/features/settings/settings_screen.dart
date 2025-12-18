import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/finance_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // App Info Section
          _buildSection(
            context,
            'Información de la app',
            [
              _buildInfoTile(
                context,
                'Versión',
                '1.0.0',
                Icons.info_outline,
              ),
              _buildInfoTile(
                context,
                'Desarrollador',
                'Personal Finance Tracker',
                Icons.code,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Data Section
          _buildSection(
            context,
            'Datos',
            [
              Consumer<FinanceService>(
                builder: (context, financeService, child) {
                  return _buildActionTile(
                    context,
                    'Refrescar datos',
                    'Sincronizar información',
                    Icons.refresh,
                    () => financeService.refresh(),
                  );
                },
              ),
              _buildActionTile(
                context,
                'Exportar datos',
                'Próximamente disponible',
                Icons.file_download,
                null, // Disabled for now
                enabled: false,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // About Section
          _buildSection(
            context,
            'Acerca de',
            [
              _buildInfoTile(
                context,
                'Política de privacidad',
                'Todos los datos se almacenan localmente',
                Icons.privacy_tip,
              ),
              _buildInfoTile(
                context,
                'Términos de uso',
                'Aplicación de uso personal',
                Icons.description,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Finance Tracker v1.0.0\nTodos los datos se almacenan localmente en tu dispositivo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap, {
    bool enabled = true,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: enabled ? Theme.of(context).primaryColor : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: enabled ? null : Colors.grey,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: enabled ? Colors.grey[600] : Colors.grey[400],
        ),
      ),
      onTap: enabled ? onTap : null,
      trailing: enabled
          ? Icon(Icons.chevron_right, color: Colors.grey[400])
          : null,
    );
  }
}
