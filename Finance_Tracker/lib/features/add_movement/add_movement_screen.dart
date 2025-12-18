import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/models/movement.dart';
import '../../core/services/finance_service.dart';
import '../../core/constants/categories.dart';
import '../../core/utils/format.dart';
import '../../shared/theme/app_theme.dart';

class AddMovementScreen extends StatefulWidget {
  const AddMovementScreen({super.key});

  @override
  State<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  late TabController _tabController;

  bool _isIncome = true;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {
      _isIncome = _tabController.index == 0;
      _selectedCategory = null; // Reset category when switching tabs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar movimiento'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.add_circle, color: AppTheme.incomeColor),
              text: 'Ingreso',
            ),
            Tab(
              icon: Icon(Icons.remove_circle, color: AppTheme.expenseColor),
              text: 'Gasto',
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cantidad',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        hintText: '0',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa una cantidad';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Ingresa una cantidad válida';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Category Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categoría',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buildCategorySelector(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Date Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _selectDate,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, 
                                   color: Theme.of(context).primaryColor),
                              const SizedBox(width: 12),
                              Text(
                                FormatUtils.formatDate(_selectedDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveMovement,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Guardar movimiento'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = _isIncome
        ? Categories.incomeCategories
        : Categories.expenseCategories;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = _selectedCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedCategory = selected ? category : null;
            });
          },
          selectedColor: _isIncome 
              ? AppTheme.incomeColor.withOpacity(0.2)
              : AppTheme.expenseColor.withOpacity(0.2),
          checkmarkColor: _isIncome 
              ? AppTheme.incomeColor
              : AppTheme.expenseColor,
        );
      }).toList(),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveMovement() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una categoría'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final amount = double.parse(_amountController.text);
    final finalAmount = _isIncome ? amount : -amount;

    final movement = Movement(
      amount: finalAmount,
      category: _selectedCategory!,
      date: _selectedDate,
    );

    final financeService = context.read<FinanceService>();
    final success = await financeService.addMovement(movement);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Movimiento guardado correctamente'),
            backgroundColor: AppTheme.incomeColor,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(financeService.error ?? 'Error al guardar el movimiento'),
            backgroundColor: AppTheme.expenseColor,
          ),
        );
      }
    }
  }
}
