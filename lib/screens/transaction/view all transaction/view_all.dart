import 'package:flutter/material.dart';
import 'package:wallet_app/screens/transaction/filter/date_filter.dart';
import 'package:wallet_app/screens/transaction/filter/type_filter.dart';
import 'package:wallet_app/screens/transaction/search/search_field.dart';
import 'package:wallet_app/screens/transaction/view%20all%20transaction/transaction_list.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Transactions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          DAteFilterTransaction(),
          SizedBox(
            width: 10,
          ),
          TypeFilterClass(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(),
          const Expanded(
            child: TransactionList(),
          ),
        ],
      ),
    );
  }
}
