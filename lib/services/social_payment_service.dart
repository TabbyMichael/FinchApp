import '../database/database_helper.dart';
import '../models/social_payment.dart';

class SocialPaymentService {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  // Fetch social payments from the database
  Future<List<SocialPayment>> getSocialPayments() async {
    final List<Map<String, dynamic>> maps =
        await _dbHelper.queryAllSocialPayments();
    return List.generate(maps.length, (i) {
      return SocialPayment.fromDbMap(maps[i]);
    });
    // TODO: Add initial data seeding or API fetching if DB is empty
  }

  // Create a new social payment in the database
  Future<int> createSocialPayment(SocialPayment payment) async {
    return await _dbHelper.insertSocialPayment(payment.toDbMap());
  }

  // Update a participant's payment status in the database
  Future<int> updateParticipantStatus(
    String paymentId,
    String participantId,
    String status,
    double amountPaid,
  ) async {
    // Fetch the existing payment
    final List<Map<String, dynamic>> paymentMaps = await _dbHelper.database
        .then(
          (db) => db.query(
            'social_payments',
            where: 'id = ?',
            whereArgs: [paymentId],
          ),
        );

    if (paymentMaps.isEmpty) {
      throw Exception('Payment not found');
    }

    SocialPayment payment = SocialPayment.fromDbMap(paymentMaps.first);

    // Find and update the participant
    bool participantFound = false;
    for (var participant in payment.participants) {
      if (participant.id == participantId) {
        // Create a new Participant object with updated values
        final updatedParticipant = Participant(
          id: participant.id,
          name: participant.name,
          email: participant.email,
          amountOwed: participant.amountOwed,
          amountPaid: amountPaid, // Update the amount paid
          status: status, // Update the status
        );
        // Replace the old participant with the updated one
        final index = payment.participants.indexOf(participant);
        payment.participants[index] = updatedParticipant;
        participantFound = true;
        break;
      }
    }

    if (!participantFound) {
      throw Exception('Participant not found in payment');
    }

    // Update the payment in the database
    return await _dbHelper.updateSocialPayment(payment.toDbMap());
  }

  // Send a gift payment (create a new social payment)
  Future<int> sendGiftPayment({
    required double amount,
    required String currency,
    required String recipientId,
    required String recipientName,
    required String recipientEmail,
    required String message,
    String? imageUrl,
  }) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // Create a mock gift payment
    final payment = SocialPayment(
      id: 'gift${DateTime.now().millisecondsSinceEpoch}',
      amount: amount,
      currency: currency,
      senderId: 'currentUser',
      senderName: 'Current User',
      participants: [
        Participant(
          id: recipientId,
          name: recipientName,
          email: recipientEmail,
          amountOwed: amount,
          amountPaid: 0,
          status: 'pending',
        ),
      ],
      description: 'Gift Payment',
      date: DateTime.now(),
      status: 'pending',
      message: message,
      imageUrl: imageUrl,
    );

    // Insert the payment into the database
    return await _dbHelper.insertSocialPayment(payment.toDbMap());
  }
}
