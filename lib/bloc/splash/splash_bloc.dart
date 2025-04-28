import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashEvent {}

class SplashInitEvent extends SplashEvent {}

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitEvent>((event, emit) async {
      emit(SplashLoading());
      // Simulate loading time
      await Future.delayed(const Duration(seconds: 2));
      emit(SplashLoaded());
    });
  }
}
