import 'package:flutter/material.dart';
import '../models/savings_goal.dart';
import '../services/financial_service.dart';

class SavingsGoalsScreen extends StatefulWidget {
  const SavingsGoalsScreen({super.key});

  @override
  State<SavingsGoalsScreen> createState() => _SavingsGoalsScreenState();
}

class _SavingsGoalsScreenState extends State<SavingsGoalsScreen> {
  final FinancialService _financialService = FinancialService();
  late Future<List<SavingsGoal>> _goalsFuture;

  @override
  void initState() {
    super.initState();
    _goalsFuture = _financialService.getSavingsGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Savings Goals',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddGoalDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<SavingsGoal>>(
        future: _goalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.savings_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No savings goals found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first goal',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            final goals = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return _buildGoalCard(goal);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildGoalCard(SavingsGoal goal) {
    final percentCompleted = goal.percentageCompleted;
    final daysRemaining = goal.daysRemaining;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goal image if available
          if (goal.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                goal.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        goal.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            daysRemaining > 30 ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$daysRemaining days left',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (goal.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    goal.description,
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${goal.currentAmount} / ${goal.targetAmount} ${goal.currency}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(percentCompleted * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percentCompleted,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Funds'),
                      onPressed: () {
                        _showAddFundsDialog(context, goal);
                      },
                    ),
                    if (goal.isAchieved)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.celebration),
                        label: const Text('Goal Achieved!'),
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final targetAmountController = TextEditingController();
    final imageUrlController = TextEditingController();
    String currency = 'USD';
    DateTime targetDate = DateTime.now().add(const Duration(days: 90));

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Create New Savings Goal'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Goal Title',
                      hintText: 'e.g., Vacation Fund',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'e.g., Trip to Bali',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: targetAmountController,
                    decoration: const InputDecoration(
                      labelText: 'Target Amount',
                      hintText: 'e.g., 1000',
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Image URL (Optional)',
                      hintText: 'e.g., https://example.com/image.jpg',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Target Date'),
                    subtitle: Text(
                      '${targetDate.day}/${targetDate.month}/${targetDate.year}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: targetDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365 * 5),
                        ),
                      );
                      if (pickedDate != null) {
                        targetDate = pickedDate;
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
                  if (titleController.text.isEmpty ||
                      targetAmountController.text.isEmpty) {
                    return;
                  }

                  final newGoal = SavingsGoal(
                    id: 'goal${DateTime.now().millisecondsSinceEpoch}',
                    title: titleController.text,
                    description: descriptionController.text,
                    targetAmount: double.parse(targetAmountController.text),
                    currentAmount: 0.0,
                    currency: currency,
                    targetDate: targetDate,
                    createdDate: DateTime.now(),
                    imageUrl: imageUrlController.text,
                  );

                  _financialService.createSavingsGoal(newGoal).then((_) {
                    setState(() {
                      _goalsFuture = _financialService.getSavingsGoals();
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

  void _showAddFundsDialog(BuildContext context, SavingsGoal goal) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Add Funds to ${goal.title}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount (${goal.currency})',
                    hintText: 'e.g., 50',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate input
                  if (amountController.text.isEmpty) {
                    return;
                  }

                  final amount = double.parse(amountController.text);
                  final updatedGoal = SavingsGoal(
                    id: goal.id,
                    title: goal.title,
                    description: goal.description,
                    targetAmount: goal.targetAmount,
                    currentAmount: goal.currentAmount + amount,
                    currency: goal.currency,
                    targetDate: goal.targetDate,
                    createdDate: goal.createdDate,
                    imageUrl: goal.imageUrl,
                  );

                  _financialService.updateSavingsGoal(updatedGoal).then((_) {
                    setState(() {
                      _goalsFuture = _financialService.getSavingsGoals();
                    });
                    Navigator.of(ctx).pop();
                  });
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }
}
