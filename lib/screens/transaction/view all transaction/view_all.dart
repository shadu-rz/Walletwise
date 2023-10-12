import 'package:flutter/material.dart';
import 'package:wallet_wise/screens/transaction/filter/date_filter.dart';
import 'package:wallet_wise/screens/transaction/filter/type_filter.dart';
import 'package:wallet_wise/screens/transaction/search/search_field.dart';
import 'package:wallet_wise/screens/transaction/view%20all%20transaction/transaction_list.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hsbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'All Transactions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const DAteFilterTransaction(),
                  const TypeFilterClass(),
                ],
              ),
              SearchField(),
              const Expanded(
                child: TransactionList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
