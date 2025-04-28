import 'package:flutter/material.dart';
import 'package:toropaal/bloc/bloc_provider.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/savings_goals_screen.dart';
import 'screens/social_payment_screen.dart';
import 'screens/eco_friendly_screen.dart';

void main() {
  runApp(AppBlocProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
        useMaterial3: true,
      ),
      initialRoute: '/auth',
      routes: {
        '/': (ctx) => const HomeScreen(),
        '/auth': (ctx) => const AuthScreen(),
        '/budget': (ctx) => const BudgetScreen(),
        '/transactions': (ctx) => const TransactionHistoryScreen(),
        '/savings': (ctx) => const SavingsGoalsScreen(),
        '/social': (ctx) => const SocialPaymentScreen(),
        '/eco': (ctx) => const EcoFriendlyScreen(),
      },
    );
  }
}
