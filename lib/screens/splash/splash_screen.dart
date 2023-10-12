import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/provider/category_provider.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/home/home_screen.dart';
import 'package:wallet_wise/screens/splash/animated_text.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gotoHome(context);
    });
    Provider.of<CategoryProvider>(context, listen: false).refreshUiCategory();
    Provider.of<TransactionProvider>(context, listen: false)
        .refreshUiTransaction();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> gotoHome(context) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }
}
