class SocialPayment {
  final String id;
  final double amount;
  final String currency;
  final String senderId;
  final String senderName;
  final List<Participant> participants;
  final String description;
  final DateTime date;
  final String status; // pending, completed, declined
  final String? message; // Optional personalized message
  final String? imageUrl; // Optional image for the payment

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

  // Calculate total amount paid by participants
  double get totalPaid {
    return participants.fold(
      0,
      (sum, participant) => sum + participant.amountPaid,
    );
  }

  // Calculate if payment is fully settled
  bool get isSettled {
    return totalPaid >= amount;
  }

  // Factory method to create a SocialPayment from JSON data
  factory SocialPayment.fromJson(Map<String, dynamic> json) {
    return SocialPayment(
      id: json['id'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      participants:
          (json['participants'] as List)
              .map((p) => Participant.fromJson(p))
              .toList(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      message: json['message'],
      imageUrl: json['imageUrl'],
    );
  }

  // Convert SocialPayment to JSON
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
      amountOwed: json['amountOwed'].toDouble(),
      amountPaid: json['amountPaid'].toDouble(),
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
}
