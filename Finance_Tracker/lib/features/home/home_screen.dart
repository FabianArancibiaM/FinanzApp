import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/finance_service.dart';
import '../../core/utils/format.dart';
import '../../shared/widgets/balance_card.dart';
import '../../shared/widgets/movement_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar datos al inicializar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinanceService>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FormatUtils.formatMonthYear(DateTime.now())),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Consumer<FinanceService>(
        builder: (context, financeService, child) {
          if (financeService.isLoading && financeService.movements.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (financeService.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar los datos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    financeService.error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => financeService.refresh(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final balance = financeService.getCurrentMonthBalance();
          final income = financeService.getCurrentMonthIncome();
          final expenses = financeService.getCurrentMonthExpenses();
          final projection = financeService.getMonthEndProjection();
          final recentMovements = financeService.getRecentMovements();

          return RefreshIndicator(
            onRefresh: () => financeService.refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Balance Card
                  BalanceCard(
                    balance: balance,
                    income: income,
                    expenses: expenses,
                    projection: projection,
                    onTap: () => Navigator.pushNamed(context, '/month-detail'),
                  ),
                  
                  // Quick Actions
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/add-movement'),
                            icon: const Icon(Icons.add),
                            label: const Text('Agregar movimiento'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Recent Movements
                  if (recentMovements.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Movimientos recientes',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/month-detail'),
                            child: const Text('Ver todos'),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recentMovements.length,
                      itemBuilder: (context, index) {
                        final movement = recentMovements[index];
                        return MovementTile(
                          movement: movement,
                          onLongPress: () => _showDeleteDialog(context, movement),
                        );
                      },
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No hay movimientos aún',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Agrega tu primer ingreso o gasto para comenzar',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, movement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar movimiento'),
          content: Text(
            '¿Estás seguro de que quieres eliminar este movimiento de ${movement.category}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<FinanceService>().deleteMovement(movement.id!);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
