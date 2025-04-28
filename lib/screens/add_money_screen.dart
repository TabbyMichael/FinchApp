import 'package:flutter/material.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  // Define payment methods with names and icons
  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Credit Card', 'icon': Icons.credit_card},
    {'name': 'Bank Transfer', 'icon': Icons.account_balance},
    {
      'name': 'PayPal',
      'icon': Icons.paypal,
    }, // Placeholder, consider using PayPal logo asset
    {'name': 'Crypto', 'icon': Icons.currency_bitcoin}, // Placeholder
    {
      'name': 'Mpesa',
      'icon': Icons.phone_android,
    }, // Placeholder, consider using Mpesa logo asset
  ];
  final _amountController = TextEditingController();
  String? _selectedPaymentMethodName; // Store the name of the selected method

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Money'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethodName,
              hint: const Text('Select Payment Method'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // prefixIcon: Icon(Icons.payment), // Icon inside the dropdown item now
              ),
              items:
                  _paymentMethods.map((method) {
                    return DropdownMenuItem<String>(
                      value: method['name'] as String,
                      child: Row(
                        children: [
                          Icon(
                            method['icon'] as IconData,
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .primary, // Optional: style the icon
                          ),
                          const SizedBox(width: 10),
                          Text(method['name'] as String),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethodName = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement the logic to process the added money
                final amount = double.tryParse(_amountController.text);
                if (amount != null && _selectedPaymentMethodName != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Adding $amount via $_selectedPaymentMethodName... (Not implemented)',
                      ),
                    ),
                  );
                  // Potentially navigate back or show success message
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter amount and select method.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Confirm Add Money'),
            ),
          ],
        ),
      ),
    );
  }
}
