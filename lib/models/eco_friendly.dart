import 'package:flutter/material.dart';

class CarbonFootprint {
  final String id;
  final String category;
  final double carbonAmount;
  final DateTime date;
  final String description;
  final IconData icon;

  CarbonFootprint({
    required this.id,
    required this.category,
    required this.carbonAmount,
    required this.date,
    required this.description,
    required this.icon,
  });
}

class SustainableInvestment {
  final String id;
  final String name;
  final String category;
  final double amount;
  final double impactScore;
  final String description;
  final IconData icon;

  SustainableInvestment({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.impactScore,
    required this.description,
    required this.icon,
  });
}

class EcoCharity {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final IconData icon;

  EcoCharity({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.icon,
  });
}
