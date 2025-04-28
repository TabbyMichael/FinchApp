import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../services/financial_service.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final FinancialService _financialService = FinancialService();
  late Future<List<Budget>> _budgetsFuture;

  @override
  void initState() {
    super.initState();
    _budgetsFuture = _financialService.getUserBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Budget Tracker',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddBudgetDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Budget>>(
        future: _budgetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No budgets found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first budget',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            final budgets = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return _buildBudgetCard(budget);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildBudgetCard(Budget budget) {
    final percentSpent = budget.percentageSpent;
    final isOverBudget = budget.isOverBudget;

    Color progressColor;
    if (isOverBudget) {
      progressColor = Colors.red;
    } else if (percentSpent > 0.75) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  budget.category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${budget.spent} / ${budget.limit} ${budget.currency}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isOverBudget ? Colors.red : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: isOverBudget ? 1.0 : percentSpent,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOverBudget
                      ? 'Over budget by ${(budget.spent - budget.limit).toStringAsFixed(2)} ${budget.currency}'
                      : 'Remaining: ${budget.remaining.toStringAsFixed(2)} ${budget.currency}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isOverBudget ? Colors.red : Colors.black54,
                  ),
                ),
                Text(
                  '${(percentSpent * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isOverBudget ? Colors.red : Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBudgetDialog(BuildContext context) {
    final categoryController = TextEditingController();
    final limitController = TextEditingController();
    String currency = 'USD';

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Create New Budget'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'e.g., Food, Transportation',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: limitController,
                    decoration: const InputDecoration(
                      labelText: 'Monthly Limit',
                      hintText: 'e.g., 500',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: currency,
                    decoration: const InputDecoration(labelText: 'Currency'),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        currency = value;
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (categoryController.text.isEmpty ||
                      limitController.text.isEmpty) {
                    return;
                  }

                  final newBudget = Budget(
                    id: 'budget${DateTime.now().millisecondsSinceEpoch}',
                    category: categoryController.text,
                    limit: double.parse(limitController.text),
                    spent: 0.0,
                    currency: currency,
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(days: 30)),
                  );

                  _financialService.createBudget(newBudget).then((_) {
                    setState(() {
                      _budgetsFuture = _financialService.getUserBudgets();
                    });
                    Navigator.of(ctx).pop();
                  });
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }
}
