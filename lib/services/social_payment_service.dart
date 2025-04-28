import '../models/social_payment.dart';

class SocialPaymentService {
  // Simulate fetching social payments
  Future<List<SocialPayment>> getSocialPayments() async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      SocialPayment(
        id: 'sp1',
        amount: 120.0,
        currency: 'USD',
        senderId: 'user1',
        senderName: 'Alex Johnson',
        participants: [
          Participant(
            id: 'user2',
            name: 'Sarah Williams',
            email: 'sarah@example.com',
            amountOwed: 40.0,
            amountPaid: 40.0,
            status: 'paid',
          ),
          Participant(
            id: 'user3',
            name: 'Mike Chen',
            email: 'mike@example.com',
            amountOwed: 40.0,
            amountPaid: 0.0,
            status: 'pending',
          ),
          Participant(
            id: 'user4',
            name: 'Jessica Lee',
            email: 'jessica@example.com',
            amountOwed: 40.0,
            amountPaid: 40.0,
            status: 'paid',
          ),
        ],
        description: 'Dinner at Italian Restaurant',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'pending',
        message: 'Thanks for a great evening!',
      ),
      SocialPayment(
        id: 'sp2',
        amount: 75.0,
        currency: 'USD',
        senderId: 'user5',
        senderName: 'David Wilson',
        participants: [
          Participant(
            id: 'user1',
            name: 'Alex Johnson',
            email: 'alex@example.com',
            amountOwed: 25.0,
            amountPaid: 25.0,
            status: 'paid',
          ),
          Participant(
            id: 'user3',
            name: 'Mike Chen',
            email: 'mike@example.com',
            amountOwed: 25.0,
            amountPaid: 25.0,
            status: 'paid',
          ),
          Participant(
            id: 'user6',
            name: 'Emma Davis',
            email: 'emma@example.com',
            amountOwed: 25.0,
            amountPaid: 25.0,
            status: 'paid',
          ),
        ],
        description: 'Movie tickets',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: 'completed',
      ),
    ];
  }

  // Simulate creating a new social payment
  Future<SocialPayment> createSocialPayment(SocialPayment payment) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // Return the payment with a generated ID (in a real app, this would come from the backend)
    return payment;
  }

  // Simulate updating a participant's payment status
  Future<SocialPayment> updateParticipantStatus(
    String paymentId,
    String participantId,
    String status,
    double amountPaid,
  ) async {
    // This would normally be an API call to a backend service
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    // In a real app, we would update the payment in the database and return the updated payment
    // For now, we'll just return a mock payment
    return getSocialPayments().then((payments) => payments.first);
  }

  // Simulate sending a gift payment with a message
  Future<SocialPayment> sendGiftPayment({
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

    return payment;
  }
}
