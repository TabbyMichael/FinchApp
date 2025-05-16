import 'dart:convert';
import '../database/database_helper.dart';
import '../models/carbon_footprint.dart';
import '../models/sustainable_investment.dart'; // Import the moved model
import '../models/eco_donation.dart'; // Import the moved model
import '../models/transaction.dart';
// Remove import for eco_friendly_screen.dart if EcoDonation was moved
// import '../screens/eco_friendly_screen.dart';

class EcoFriendlyService {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  // Fetch carbon footprint data from the database
  Future<List<CarbonFootprint>> getCarbonFootprint() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.queryAllCarbonFootprints();
    // Convert the List<Map<String, dynamic> into a List<CarbonFootprint>.
    return List.generate(maps.length, (i) {
      return CarbonFootprint.fromDbMap(maps[i]);
    });
    // TODO: Add initial data seeding or API fetching if DB is empty
  }

  // Add a new carbon footprint record
  Future<void> addCarbonFootprint(CarbonFootprint footprint) async {
    await _dbHelper.insertCarbonFootprint(footprint.toDbMap());
  }

  // Fetch sustainable investment options from the database
  Future<List<SustainableInvestment>> getSustainableInvestments() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.queryAllSustainableInvestments();
    return maps.map((map) => SustainableInvestment.fromDbMap(map)).toList();
  }

  // Add a new sustainable investment record
  Future<void> addSustainableInvestment(
    SustainableInvestment investment,
  ) async {
    await _dbHelper.insertSustainableInvestment(investment.toDbMap());
  }

  // Simulate making a donation to environmental causes
  Future<bool> makeDonation(EcoDonation donation) async {
    try {
      await _dbHelper.insertEcoDonation(donation.toDbMap());
      return true;
    } catch (e) {
      print('Donation failed: \$e');
      return false;
    }
  }

  // Get eco-friendly donation options from the database
  Future<List<EcoDonation>> getEcoDonations() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.queryAllEcoDonations();
    return List.generate(maps.length, (i) {
      return EcoDonation.fromDbMap(maps[i]);
    });
    // TODO: Add initial data seeding or API fetching if DB is empty
  }

  // Add a new eco donation record
  Future<void> addEcoDonation(EcoDonation donation) async {
    await _dbHelper.insertEcoDonation(donation.toDbMap());
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
