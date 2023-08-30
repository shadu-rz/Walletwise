import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_app/models/category/category_model.dart';
import 'package:wallet_app/provider/transaction_provider.dart';
import '../../../models/transactions/transaction_model.dart';

class ExpenseChart extends StatelessWidget {
   ExpenseChart({super.key});


 final TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<TransactionProvider>(
          builder: (context, value, _) {
            var allIncome = value.transactionListProvider
                .where((element) => element.type == CategoryType.expense)
                .toList();
            return value.overviewGraphTransactions. isEmpty
                ? const SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Data Found!!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: tooltipBehavior,
                    series: <CircularSeries>[
                      DoughnutSeries<TransactionModel, String>(
                          dataSource: allIncome,
                          xValueMapper: (TransactionModel expenseDate, _) =>
                              expenseDate.category.name,
                          yValueMapper: (TransactionModel expenseDate, _) =>
                              expenseDate.amount,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelIntersectAction: LabelIntersectAction.none,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          enableTooltip: true)
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      alignment: ChartAlignment.center,
                    ),
                    // primaryXAxis: CategoryAxis(),
                  );
          },
        ),
      ),
    );
  }
}
