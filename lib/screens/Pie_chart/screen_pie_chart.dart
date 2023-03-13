import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:wallet_app/db/db_transaction/transaction_db.dart';
import 'package:wallet_app/screens/Pie_chart/expenses/expense_chart.dart';
import 'package:wallet_app/screens/Pie_chart/overAll/graph_over_view.dart';
import 'package:wallet_app/screens/Pie_chart/income/income_chart.dart';

class PieChartAll extends StatefulWidget {
  const PieChartAll({super.key});

  @override
  State<PieChartAll> createState() => _PieChartAllState();
}

class _PieChartAllState extends State<PieChartAll> {
  String dateFilterTitle = "All";
  @override
  void initState() {
    overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<int>(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Row(
                    children: const [
                      Text(''),
                      Icon(
                        Icons.sort,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: const Text(
                      'All',
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      setState(() {
                        dateFilterTitle = "All";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'Today',
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.day == DateTime.now().day &&
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Today";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'Yesterday',
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.day == DateTime.now().day - 1 &&
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Yesterday";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'This Month',
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;

                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Month";
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
                child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: ButtonsTabBar(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 40),
                        tabs: const [
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'All',
                          ),
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'Income',
                          ),
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'Expense',
                          ),
                        ]),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        GraphOverView(),
                        IncomeChart(),
                        ExpenseChart()
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
