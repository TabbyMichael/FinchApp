import 'dart:convert';

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

  // Convert SustainableInvestment from Database Map
  factory SustainableInvestment.fromDbMap(Map<String, dynamic> map) {
    return SustainableInvestment(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      returnRate: map['returnRate'],
      riskLevel: map['riskLevel'],
      minInvestment: map['minInvestment'],
      currency: map['currency'],
      sustainabilityCategories: List<String>.from(
        json.decode(map['sustainabilityCategories']),
      ),
      impactScore: map['impactScore'],
    );
  }

  // Convert SustainableInvestment to Database Map
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'returnRate': returnRate,
      'riskLevel': riskLevel,
      'minInvestment': minInvestment,
      'currency': currency,
      // Assuming sustainabilityCategories is stored as a comma-separated string
      'sustainabilityCategories': json.encode(sustainabilityCategories),
      'impactScore': impactScore,
    };
  }
}
