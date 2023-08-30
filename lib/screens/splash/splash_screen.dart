import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/provider/category_provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';
import 'package:wallet_app/screens/home/home_screen.dart';
import 'package:wallet_app/screens/splash/animated_text.dart';

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> gotoHome(context) async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }
}
