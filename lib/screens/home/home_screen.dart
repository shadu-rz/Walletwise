import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/models/category/category_model.dart';
import 'package:wallet_app/models/transactions/transaction_model.dart';
import 'package:wallet_app/provider/category_provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';
import 'package:wallet_app/screens/Pie_chart/screen_pie_chart.dart';
import 'package:wallet_app/screens/home/widgets/floating_action.dart';
import 'package:wallet_app/screens/settings_screen/settings_screen.dart';
import 'package:wallet_app/screens/transaction/edit/edit_trans.dart';
import 'package:wallet_app/screens/transaction/view%20all%20transaction/view_all.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
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
                            child: Icon(
                              Icons.settings,
                            ),
                          ),
                          onTap: () {
                            // return showMenuModalBottomSheet(context);
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(
                                'WalletApp',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 7, 72),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<TransactionProvider>(
                          builder: (ctx, value, child) {
                            return Column(
                              children: [
                                value.totalBalance >= 0
                                    ? const Text(
                                        'Balance',
                                        style: TextStyle(
                                          fontSize: 20,
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
                                          color: Color.fromARGB(210, 0, 7, 72),
                                        ),
                                      )
                                    : Text(
                                        '-${value.totalBalance.abs().toString()} ₹',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.red,
                                        ),
                                      )
                              ],
                            );
                          },
                          //
                        )
                      ],
                    ),
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
                                    color: Colors.green,
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
                      SizedBox(
                        width: screenSize.width * 0.03,
                      ),
                      Consumer<TransactionProvider>(
                          builder: (context, value, _) {
                        return Container(
                          height: screenSize.width * 0.25,
                          width: screenSize.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          child: Card(
                            elevation: 5,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
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
                                  label: const Text('Statistics'),
                                ),
                                // color: Colors.amber,
                              ),
                              SizedBox(
                                height: screenSize.width * 0.11,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Transactions',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black45,
                                        
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                // color: Colors.blue,
                              ),
                              SizedBox(
                                height: screenSize.width * 0.11,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // showSearch(
                                    //   context: context,
                                    //   delegate: SearchWidget(),
                                    // );
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                // color: Colors.blue,
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
                              final editValue = TransactionModel(
                                id: value.id,
                                purpose: value.purpose,
                                amount: value.amount,
                                date: value.date,
                                type: value.type,
                                category: value.category,
                              );
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    //    EDIT  ICON

                                    SlidableAction(
                                      icon: Icons.edit,
                                      label: 'edit',
                                      onPressed: (context) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                EditTransaction(
                                                  obj: editValue,
                                                )),
                                          ),
                                        );
                                      },
                                    ),

                                    // DELETE   ICON

                                    SlidableAction(
                                      onPressed: ((context) {
                                        showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return AlertDialog(
                                              content: const Text(
                                                'Do you want to Delete',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: (() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: const Text(
                                                        'No',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: (() {
                                                        provider
                                                            .deleteTransaction(
                                                                value);
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: const Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      }),
                                      icon: Icons.delete,
                                      foregroundColor: Colors.red,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                key: Key(value.id!),
                                child: Card(
                                  color: value.type == CategoryType.income
                                      ? Colors.green
                                      : Colors.red,
                                  elevation: 5,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        child: Text(
                                          parseDate(value.date),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      title: Text(
                                        value.category.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        value.purpose,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: Text(
                                        '₹${value.amount}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(
                                height: screenSize.width * 0.01,
                              );
                            },
                            itemCount: provider.transactionListProvider.length,
                          )
                        : const SizedBox(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 130),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Data Transactions Found!!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       const SizedBox(width: 10),
      //       FloatingActionButton.extended(
      //         label: const Text('Category'),
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => const CategoryScreen(),
      //           ));
      //         },
      //         // child: const Text('Category'),
      //       ),
      //       // const Spacer(),
      //       FloatingActionButton.extended(
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => ScreenAddTransaction(),
      //           ));
      //         },
      //         label: const Text('Add Transaction'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
