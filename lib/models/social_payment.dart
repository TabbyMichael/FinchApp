import 'dart:convert'; // Required for jsonEncode and jsonDecode

class SocialPayment {
  final String id;
  final double amount;
  final String currency;
  final String senderId;
  final String senderName;
  final List<Participant> participants;
  final String description;
  final DateTime date;
  final String status; // e.g., pending, completed, failed
  final String? message; // Optional message from sender
  final String? imageUrl; // Optional image URL for the gift

  SocialPayment({
    required this.id,
    required this.amount,
    required this.currency,
    required this.senderId,
    required this.senderName,
    required this.participants,
    required this.description,
    required this.date,
    required this.status,
    this.message,
    this.imageUrl,
  });

  // Factory method to create a SocialPayment from JSON data (e.g., API response)
  factory SocialPayment.fromJson(Map<String, dynamic> json) {
    return SocialPayment(
      id: json['id'],
      amount: _ensureDouble(json['amount']),
      currency: json['currency'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      participants:
          (json['participants'] as List)
              .map((p) => Participant.fromJson(p as Map<String, dynamic>))
              .toList(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      message: json['message'],
      imageUrl: json['imageUrl'],
    );
  }

  // Convert SocialPayment to JSON (e.g., for API request)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'senderId': senderId,
      'senderName': senderName,
      'participants': participants.map((p) => p.toJson()).toList(),
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'message': message,
      'imageUrl': imageUrl,
    };
  }

  // Factory method to create a SocialPayment from a database map
  factory SocialPayment.fromDbMap(Map<String, dynamic> map) {
    return SocialPayment(
      id: map['id'],
      amount: _ensureDouble(map['amount']),
      currency: map['currency'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      participants:
          (jsonDecode(map['participants']) as List)
              .map(
                (pJson) => Participant.fromDbMap(pJson as Map<String, dynamic>),
              )
              .toList(),
      description: map['description'],
      date: DateTime.parse(map['date']),
      status: map['status'],
      message: map['message'],
      imageUrl: map['imageUrl'],
    );
  }

  // Convert SocialPayment to a database map
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'senderId': senderId,
      'senderName': senderName,
      'participants': jsonEncode(
        participants.map((p) => p.toDbMap()).toList(),
      ), // Encode participants list to JSON string
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'message': message,
      'imageUrl': imageUrl,
    };
  }
}

class Participant {
  final String id;
  final String name;
  final String email;
  final double amountOwed;
  final double amountPaid;
  final String status; // pending, paid, declined

  Participant({
    required this.id,
    required this.name,
    required this.email,
    required this.amountOwed,
    required this.amountPaid,
    required this.status,
  });

  // Calculate if participant has fully paid
  bool get hasPaid => amountPaid >= amountOwed;

  // Factory method to create a Participant from JSON data
  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      amountOwed: _ensureDouble(json['amountOwed']),
      amountPaid: _ensureDouble(json['amountPaid']),
      status: json['status'],
    );
  }

  // Convert Participant to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'amountOwed': amountOwed,
      'amountPaid': amountPaid,
      'status': status,
    };
  }

  // Factory method to create a Participant from a database map
  factory Participant.fromDbMap(Map<String, dynamic> map) {
    return Participant(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      amountOwed: _ensureDouble(map['amountOwed']),
      amountPaid: _ensureDouble(map['amountPaid']),
      status: map['status'],
    );
  }

  // Convert Participant to a database map
  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'amountOwed': amountOwed,
      'amountPaid': amountPaid,
      'status': status,
    };
  }
}

// Helper to ensure double conversion from dynamic, handling int, double, or String
double _ensureDouble(dynamic value) {
  if (value == null) return 0.0; // Handle null case
  if (value is int) {
    return value.toDouble();
  }
  if (value is double) {
    return value;
  }
  if (value is String) {
    return double.tryParse(value) ??
        0.0; // Handle string case, default to 0.0 if parsing fails
  }
  // Fallback for other types or if a more specific error is needed
  // Consider logging or throwing an error for unexpected types
  // For now, defaulting to 0.0 to prevent runtime crashes if data is malformed
  print(
    'Warning: _ensureDouble received unexpected type: ${value.runtimeType}, value: $value. Defaulting to 0.0.',
  );
  return 0.0;
}
