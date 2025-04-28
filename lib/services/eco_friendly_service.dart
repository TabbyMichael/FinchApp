import '../models/carbon_footprint.dart';
import '../models/transaction.dart';
import '../screens/eco_friendly_screen.dart';

class EcoFriendlyService {
  // Simulate fetching carbon footprint data for transactions
  Future<List<CarbonFootprint>> getCarbonFootprint() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      CarbonFootprint(
        id: 'cf1',
        transactionId: 'tx1',
        carbonAmount: 2.5,
        category: 'Transportation',
        date: DateTime.now().subtract(const Duration(days: 2)),
        details: {'transportType': 'Taxi', 'distance': '5 miles'},
      ),
      CarbonFootprint(
        id: 'cf2',
        transactionId: 'tx2',
        carbonAmount: 1.2,
        category: 'Food',
        date: DateTime.now().subtract(const Duration(days: 5)),
        details: {'foodType': 'Restaurant', 'mealType': 'Dinner'},
      ),
      CarbonFootprint(
        id: 'cf3',
        transactionId: 'tx3',
        carbonAmount: 0.8,
        category: 'Shopping',
        date: DateTime.now().subtract(const Duration(hours: 12)),
        details: {'storeType': 'Clothing', 'items': 'Apparel'},
      ),
    ];
  }

  // Simulate fetching sustainable investment options
  Future<List<SustainableInvestment>> getSustainableInvestments() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      SustainableInvestment(
        id: 'si1',
        name: 'Green Energy Fund',
        description: 'Invests in renewable energy companies and projects',
        returnRate: 5.2,
        riskLevel: 'medium',
        minInvestment: 100.0,
        currency: 'USD',
        sustainabilityCategories: ['Renewable Energy', 'Clean Tech'],
        impactScore: 8.5,
      ),
      SustainableInvestment(
        id: 'si2',
        name: 'Sustainable Water Portfolio',
        description:
            'Focuses on water conservation and clean water technologies',
        returnRate: 4.8,
        riskLevel: 'low',
        minInvestment: 50.0,
        currency: 'USD',
        sustainabilityCategories: ['Water Conservation', 'Clean Water'],
        impactScore: 7.9,
      ),
      SustainableInvestment(
        id: 'si3',
        name: 'Eco-Innovation Fund',
        description: 'Invests in startups developing sustainable solutions',
        returnRate: 7.5,
        riskLevel: 'high',
        minInvestment: 250.0,
        currency: 'USD',
        sustainabilityCategories: [
          'Innovation',
          'Circular Economy',
          'Sustainable Materials',
        ],
        impactScore: 9.2,
      ),
    ];
  }

  // Simulate making a donation to environmental causes
  Future<bool> makeDonation({
    required String cause,
    required double amount,
    required String currency,
  }) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // In a real app, we would process the donation and return success/failure
    return true;
  }

  // Get eco-friendly donation options
  Future<List<EcoDonation>> getEcoDonations() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      EcoDonation(
        id: 'ed1',
        name: 'Ocean Cleanup Foundation',
        category: 'Ocean Conservation',
        description:
            'Developing advanced technologies to rid the world\'s oceans of plastic.',
      ),
      EcoDonation(
        id: 'ed2',
        name: 'Rainforest Trust',
        category: 'Forest Conservation',
        description:
            'Protecting threatened tropical forests and endangered wildlife.',
      ),
      EcoDonation(
        id: 'ed3',
        name: 'Climate Action Network',
        category: 'Climate Change',
        description:
            'Working to promote government and individual action to limit human-induced climate change.',
      ),
    ];
    // For now, we'll just return success
  }

  // Simulate calculating carbon offset for a transaction
  Future<double> calculateCarbonOffset(Transaction transaction) async {
    // This would normally involve a complex calculation based on transaction data
    // For now, we'll use a simple calculation
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate processing time

    // Simple mock calculation based on transaction amount
    // In a real app, this would use category, merchant data, etc.
    final carbonOffset =
        transaction.amount * 0.01; // 1% of transaction amount as kg CO2

    return carbonOffset;
  }

  // Simulate getting environmental impact summary
  Future<Map<String, dynamic>> getEnvironmentalImpactSummary() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return {
      'totalCarbonFootprint': 45.2, // kg CO2
      'carbonOffsetPurchased': 20.0, // kg CO2
      'netCarbonFootprint': 25.2, // kg CO2
      'treesPlanted': 5,
      'waterSaved': 1250, // liters
      'plasticAvoided': 3.5, // kg
      'totalDonations': 75.0, // USD
      'impactScore': 82, // out of 100
    };
  }
}
