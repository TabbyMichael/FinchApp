import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toropaal/models/social_payment.dart';

part 'social_payment_event.dart';
part 'social_payment_state.dart';

class SocialPaymentBloc extends Bloc<SocialPaymentEvent, SocialPaymentState> {
  SocialPaymentBloc() : super(SocialPaymentInitial()) {
    on<SocialPaymentLoadRequested>((event, emit) {
      // TODO: implement social payment load
    });
    on<SocialPaymentAdded>((event, emit) {
      // TODO: implement social payment added
    });
    on<SocialPaymentUpdated>((event, emit) {
      // TODO: implement social payment updated
    });
    on<SocialPaymentDeleted>((event, emit) {
      // TODO: implement social payment deleted
    });
  }
}
