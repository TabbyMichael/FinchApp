part of 'social_payment_bloc.dart';

abstract class SocialPaymentEvent {
  const SocialPaymentEvent();
}

class SocialPaymentLoadRequested extends SocialPaymentEvent {}

class SocialPaymentAdded extends SocialPaymentEvent {
  final SocialPayment payment;

  const SocialPaymentAdded(this.payment);
}

class SocialPaymentUpdated extends SocialPaymentEvent {
  final SocialPayment payment;

  const SocialPaymentUpdated(this.payment);
}

class SocialPaymentDeleted extends SocialPaymentEvent {
  final String paymentId;

  const SocialPaymentDeleted(this.paymentId);
}
