import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OnboardingEvent {}

class OnboardingInitEvent extends OnboardingEvent {}

class OnboardingCompleteEvent extends OnboardingEvent {}

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingReady extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingInitEvent>((event, emit) async {
      emit(OnboardingLoading());
      // Simulate loading time
      await Future.delayed(const Duration(seconds: 1));
      emit(OnboardingReady());
    });

    on<OnboardingCompleteEvent>((event, emit) {
      emit(OnboardingCompleted());
    });
  }
}
