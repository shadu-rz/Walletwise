import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/models/transactions/transaction_model.dart';
import 'package:wallet_wise/provider/category_provider.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/Pie_chart/screen_pie_chart.dart';
import 'package:wallet_wise/screens/category/screen_category.dart';
import 'package:wallet_wise/screens/home/widgets/floating_action.dart';
import 'package:wallet_wise/screens/settings/settings_screen.dart';
import 'package:wallet_wise/screens/transaction/edit/edit_trans.dart';
import 'package:wallet_wise/screens/transaction/view%20all%20transaction/slidable.dart';
import 'package:wallet_wise/screens/transaction/view%20all%20transaction/view_all.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    // required this.transaction,
  });
  // final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TransactionProvider>(context, listen: false)
          .incomeAndExpense();
      Provider.of<TransactionProvider>(context, listen: false)
              .overviewGraphTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .transactionListProvider;
    });
    final screenSize = MediaQuery.of(context).size;

    Provider.of<CategoryProvider>(context, listen: false).refreshUiCategory();
    Provider.of<TransactionProvider>(context, listen: false)
        .refreshUiTransaction();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/hsbg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenSize.width * 0.2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.05,
                        ),
                        GestureDetector(
                          child: const CircleAvatar(
                            backgroundColor: Colors.white54,
                            child: Icon(
                              Icons.settings,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ScreenSettings(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: screenSize.width * 0.5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(40, 0, 7, 72),
                          ),
                          width: screenSize.width * 0.3,
                          height: screenSize.width * 0.1,
                          // color: Colors.amber,
                          child: const Center(
                            child: Text(
                              'Walletwise',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 7, 72),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<TransactionProvider>(
                        builder: (ctx, value, child) {
                          return Container(
                            height: screenSize.width * 0.2,
                            width: screenSize.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  value.totalBalance >= 0
                                      ? const Text(
                                          'Balance',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        )
                                      : const Text(
                                          'Loss',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                  value.totalBalance >= 0
                                      ? Text(
                                          '${value.totalBalance.abs().toString()} ₹',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            color:
                                                Color.fromRGBO(0, 7, 72, 0.824),
                                          ),
                                        )
                                      : Text(
                                          '-${value.totalBalance.abs().toString()} ₹',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.red,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                        //
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<TransactionProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: screenSize.width * 0.25,
                                  width: screenSize.width * 0.4,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_upward_rounded,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              'Income',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${value.incomeTotal} ₹',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      Consumer<TransactionProvider>(
                          builder: (context, value, _) {
                        return Container(
                          height: screenSize.width * 0.25,
                          width: screenSize.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Card(
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                                Text(
                                  '${value.expenseTotal} ₹',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: screenSize.width * 0.1,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const CategoryScreen()),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.category),
                                    label: const Text('Categories',style: TextStyle(fontSize: 9),),
                                  ),
                                  // color: Colors.amber,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: screenSize.width * 0.1,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              const PieChartAll()),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.pie_chart),
                                    label: const Text('Statistics',style: TextStyle(fontSize: 10),),
                                  ),
                                  // color: Colors.amber,
                                ),
                              ),
                             
                              Expanded(
                                child: SizedBox(
                                  height: screenSize.width * 0.11,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      context
                                              .read<TransactionProvider>()
                                              .overviewTransactions =
                                          Provider.of<TransactionProvider>(
                                                  context,
                                                  listen: false)
                                              .transactionListProvider;
                                      context
                                          .read<TransactionProvider>()
                                          .notifyListeners();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const ViewAll(),
                                      ));
                                    },
                                    icon: const Icon(Icons.search),
                                    label: const Text('Search'),
                                  ),
                                  // color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.6,
                child: Consumer<TransactionProvider>(
                  builder: (ctx, provider, Widget? _) {
                    return provider.transactionListProvider.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (ctx, index) {
                              final value =
                                  provider.transactionListProvider[index];
                              final transaction = TransactionModel(
                                id: value.id,
                                purpose: value.purpose,
                                amount: value.amount,
                                date: value.date,
                                type: value.type,
                                category: value.category,
                              );
                              return SlidableTransaction(
                                  transaction: transaction);
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(
                                height: screenSize.width * 0.01,
                              );
                            },
                            itemCount: provider.transactionListProvider.length,
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 180),
                            child: Lottie.asset(
                              'assets/lotties/animation_ln4pztav.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingActionHomeScreen(),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
