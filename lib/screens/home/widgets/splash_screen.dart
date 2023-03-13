
import 'package:flutter/material.dart';
import 'package:wallet_app/db/db_category/category_db.dart';
import 'package:wallet_app/db/db_transaction/transaction_db.dart';
import 'package:wallet_app/screens/home/home_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    gotoHome();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refresh();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 7, 72),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'WalletApp',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((ctx) {
          return const HomeScreen();
        }),
      ),
    );
  }
}
