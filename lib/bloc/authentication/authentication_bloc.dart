import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationStarted>((event, emit) {
      // TODO: implement authentication started
    });
    on<AuthenticationLoggedIn>((event, emit) {
      // TODO: implement logged in
    });
    on<AuthenticationLoggedOut>((event, emit) {
      // TODO: implement logged out
    });
  }
}
