import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wallet_wise/screens/category/screen_category.dart';
import 'package:wallet_wise/screens/transaction/add/screen_add_transaction.dart';

class FloatingActionHomeScreen extends StatelessWidget {
  const FloatingActionHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      label: const Text(
        'Add here',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: Icons.add,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.category),
          label: 'CATEGORIES',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.money_rounded),
          label: 'ADD TRANSACTION',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => ScreenAddTransaction()),
              ),
            );
          },
        ),
      ],
    );
  }
}
