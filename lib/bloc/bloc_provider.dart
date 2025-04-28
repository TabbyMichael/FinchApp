import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/authentication_bloc.dart';
import 'transaction/transaction_bloc.dart';
import 'balance/balance_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()),
        BlocProvider<BalanceBloc>(create: (context) => BalanceBloc()),
      ],
      child: child,
    );
  }
}
