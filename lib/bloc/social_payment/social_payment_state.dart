part of 'social_payment_bloc.dart';

abstract class SocialPaymentState {
  const SocialPaymentState();
}

class SocialPaymentInitial extends SocialPaymentState {}

class SocialPaymentLoadInProgress extends SocialPaymentState {}

class SocialPaymentLoadSuccess extends SocialPaymentState {
  final List<SocialPayment> payments;

  const SocialPaymentLoadSuccess(this.payments);
}

class SocialPaymentOperationSuccess extends SocialPaymentState {}

class SocialPaymentFailure extends SocialPaymentState {
  final String error;

  const SocialPaymentFailure(this.error);
}
