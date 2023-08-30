import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';
import 'package:wallet_app/screens/Pie_chart/expenses/expense_chart.dart';
import 'package:wallet_app/screens/Pie_chart/overAll/graph_over_view.dart';
import 'package:wallet_app/screens/Pie_chart/income/income_chart.dart';

class PieChartAll extends StatelessWidget {
  const PieChartAll({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<TransactionProvider>().overviewGraphTransactions =
          context.read<TransactionProvider>().transactionListProvider,
    );
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
              Consumer<TransactionProvider>(builder: (context, value, _) {
                return PopupMenuButton<int>(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(''),
                    ],
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: const Text(
                        'All',
                      ),
                      onTap: () {
                        value.setOverViewGraphTransactions =
                            value.transactionListProvider;
                        value.dateFilterTitle = "All";
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        'Today',
                      ),
                      onTap: () {
                        value.setOverViewGraphTransactions =
                            value.transactionListProvider;
                        value.setOverViewGraphTransactions = value
                            .overviewGraphTransactions
                            .where((element) =>
                                element.date.day == DateTime.now().day &&
                                element.date.month == DateTime.now().month &&
                                element.date.year == DateTime.now().year)
                            .toList();
                        value.dateFilterTitle = "Today";
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        'Yesterday',
                      ),
                      onTap: () {
                        value.setOverViewGraphTransactions =
                            value.transactionListProvider;
                        value.setOverViewGraphTransactions = value
                            .overviewGraphTransactions
                            .where((element) =>
                                element.date.day == DateTime.now().day - 1 &&
                                element.date.month == DateTime.now().month &&
                                element.date.year == DateTime.now().year)
                            .toList();

                        value.dateFilterTitle = "Yesterday";
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        'This Month',
                      ),
                      onTap: () {
                        value.setOverViewGraphTransactions =
                            value.transactionListProvider;
                        value.setOverViewGraphTransactions = value
                            .overviewGraphTransactions
                            .where((element) =>
                                element.date.month == DateTime.now().month &&
                                element.date.year == DateTime.now().year)
                            .toList();

                        value.dateFilterTitle = "Month";
                      },
                    ),
                  ],
                );
              })
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
                  Expanded(
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
