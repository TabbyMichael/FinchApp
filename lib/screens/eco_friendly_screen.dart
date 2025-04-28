import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/carbon_footprint.dart';
import '../services/eco_friendly_service.dart';

class EcoFriendlyScreen extends StatefulWidget {
  const EcoFriendlyScreen({super.key});

  @override
  State<EcoFriendlyScreen> createState() => _EcoFriendlyScreenState();
}

class _EcoFriendlyScreenState extends State<EcoFriendlyScreen>
    with SingleTickerProviderStateMixin {
  final EcoFriendlyService _ecoService = EcoFriendlyService();
  late TabController _tabController;
  late Future<List<CarbonFootprint>> _carbonFootprintFuture;
  late Future<List<SustainableInvestment>> _investmentsFuture;
  late Future<List<EcoDonation>> _donationsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _carbonFootprintFuture = _ecoService.getCarbonFootprint();
    _investmentsFuture = _ecoService.getSustainableInvestments();
    _donationsFuture = _ecoService.getEcoDonations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Eco-Friendly Banking',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Carbon Footprint', icon: Icon(Icons.eco)),
            Tab(text: 'Sustainable Investments', icon: Icon(Icons.trending_up)),
            Tab(text: 'Donations', icon: Icon(Icons.volunteer_activism)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCarbonFootprintTab(),
          _buildInvestmentsTab(),
          _buildDonationsTab(),
        ],
      ),
    );
  }

  Widget _buildCarbonFootprintTab() {
    return FutureBuilder<List<CarbonFootprint>>(
      future: _carbonFootprintFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No carbon footprint data available'),
          );
        } else {
          final footprints = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Carbon Impact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatCard(
                              'Monthly',
                              '${_calculateTotalCarbon(footprints).toStringAsFixed(1)} kg',
                              Icons.calendar_month,
                              Colors.blue,
                            ),
                            _buildStatCard(
                              'Average',
                              '${(_calculateTotalCarbon(footprints) / footprints.length).toStringAsFixed(1)} kg',
                              Icons.bar_chart,
                              Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: footprints.length,
                  itemBuilder: (context, index) {
                    final footprint = footprints[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          child: Icon(
                            _getCategoryIcon(footprint.category),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(footprint.category),
                        subtitle: Text(
                          '${footprint.date.day}/${footprint.date.month}/${footprint.date.year}',
                        ),
                        trailing: Text(
                          '${footprint.carbonAmount.toStringAsFixed(1)} kg',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildInvestmentsTab() {
    return FutureBuilder<List<SustainableInvestment>>(
      future: _investmentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No sustainable investments available'),
          );
        } else {
          final investments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: investments.length,
            itemBuilder: (context, index) {
              final investment = investments[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            child: Icon(
                              Icons.trending_up,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  investment.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Risk: ${investment.riskLevel} • Min: ${investment.minInvestment} ${investment.currency}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(investment.description),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text('${investment.returnRate}% return'),
                            backgroundColor: Colors.green[100],
                          ),
                          Row(
                            children: [
                              const Text('Impact Score: '),
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star,
                                  size: 18,
                                  color:
                                      i < (investment.impactScore / 2).round()
                                          ? Colors.amber
                                          : Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement investment action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Investing in ${investment.name}',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Invest Now'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildDonationsTab() {
    return FutureBuilder<List<EcoDonation>>(
      future: _donationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No donation options available'));
        } else {
          final donations = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            child: Icon(
                              Icons.volunteer_activism,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  donation.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  donation.category,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(donation.description),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _showDonationDialog(context, donation, 5);
                              },
                              child: const Text('\$5'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _showDonationDialog(context, donation, 10);
                              },
                              child: const Text('\$10'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _showDonationDialog(context, donation, 25);
                              },
                              child: const Text('\$25'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _showCustomDonationDialog(context, donation);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Custom'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalCarbon(List<CarbonFootprint> footprints) {
    return footprints.fold(
      0,
      (total, footprint) => total + footprint.carbonAmount,
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'transportation':
        return Icons.directions_car;
      case 'food':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_cart;
      case 'utilities':
        return Icons.electric_bolt;
      default:
        return Icons.eco;
    }
  }

  void _showDonationDialog(
    BuildContext context,
    EcoDonation donation,
    double amount,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Donate to ${donation.name}'),
            content: Text(
              'Would you like to donate \$${amount.toStringAsFixed(2)} to ${donation.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _processDonation(donation, amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Donate'),
              ),
            ],
          ),
    );
  }

  void _showCustomDonationDialog(BuildContext context, EcoDonation donation) {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Donate to ${donation.name}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter donation amount:'),
                const SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
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
                  final amount = double.tryParse(amountController.text);
                  if (amount != null && amount > 0) {
                    Navigator.of(ctx).pop();
                    _processDonation(donation, amount);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Donate'),
              ),
            ],
          ),
    );
  }

  void _processDonation(EcoDonation donation, double amount) {
    // In a real app, this would call a service to process the donation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Thank you for donating \$${amount.toStringAsFixed(2)} to ${donation.name}!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// This class is used for the donations tab
class EcoDonation {
  final String id;
  final String name;
  final String category;
  final String description;

  EcoDonation({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
  });
}
