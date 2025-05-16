import 'dart:convert';

class CarbonFootprint {
  final String id;
  final String transactionId;
  final double carbonAmount; // in kg CO2
  final String category; // e.g., transportation, food, utilities
  final DateTime date;
  final Map<String, dynamic>? details; // Additional details about the footprint

  CarbonFootprint({
    required this.id,
    required this.transactionId,
    required this.carbonAmount,
    required this.category,
    required this.date,
    this.details,
  });

  // Factory method to create a CarbonFootprint from JSON data
  factory CarbonFootprint.fromJson(Map<String, dynamic> json) {
    return CarbonFootprint(
      id: json['id'],
      transactionId: json['transactionId'],
      carbonAmount: json['carbonAmount'].toDouble(),
      category: json['category'],
      date: DateTime.parse(json['date']),
      details: json['details'],
    );
  }

  // Convert CarbonFootprint to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionId': transactionId,
      'carbonAmount': carbonAmount,
      'category': category,
      'date': date.toIso8601String(),
      'details': details,
    };
  }

  // Convert CarbonFootprint from Database Map
  factory CarbonFootprint.fromDbMap(Map<String, dynamic> map) {
    return CarbonFootprint(
      id: map['id'],
      transactionId: map['transactionId'],
      carbonAmount: map['carbonAmount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      // Assuming details is stored as a JSON string
      details: map['details'] != null ? jsonDecode(map['details']) : null,
    );
  }

  // Convert CarbonFootprint to Database Map
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'carbonAmount': carbonAmount,
      'category': category,
      'date': date.toIso8601String(),
      // Assuming details is stored as a JSON string
      'details': details != null ? jsonEncode(details) : null,
    };
  }
}

/* SustainableInvestment class removed, moved to its own file */
/*
class SustainableInvestment {
  final String id;
  final String name;
  final String description;
  final double returnRate; // Expected annual return rate
  final String riskLevel; // low, medium, high
  final double minInvestment;
  final String currency;
  final List<String>
  sustainabilityCategories; // e.g., renewable energy, conservation
  final double impactScore; // A score representing environmental impact

  SustainableInvestment({
    required this.id,
    required this.name,
    required this.description,
    required this.returnRate,
    required this.riskLevel,
    required this.minInvestment,
    required this.currency,
    required this.sustainabilityCategories,
    required this.impactScore,
  });

  // Factory method to create a SustainableInvestment from JSON data
  factory SustainableInvestment.fromJson(Map<String, dynamic> json) {
    return SustainableInvestment(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      returnRate: json['returnRate'].toDouble(),
      riskLevel: json['riskLevel'],
      minInvestment: json['minInvestment'].toDouble(),
      currency: json['currency'],
      sustainabilityCategories: List<String>.from(
        json['sustainabilityCategories'],
      ),
      impactScore: json['impactScore'].toDouble(),
    );
  }

  // Convert SustainableInvestment to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'returnRate': returnRate,
      'riskLevel': riskLevel,
      'minInvestment': minInvestment,
      'currency': currency,
      'sustainabilityCategories': sustainabilityCategories,
      'impactScore': impactScore,
    };
  }
}
*/
