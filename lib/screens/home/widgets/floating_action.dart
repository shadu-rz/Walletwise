import 'package:flutter/material.dart';
import 'package:wallet_wise/screens/transaction/add/screen_add_transaction.dart';

class FloatingActionHomeScreen extends StatelessWidget {
  const FloatingActionHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => ScreenAddTransaction()),
              ),
            );
      },
    );
  }
}
