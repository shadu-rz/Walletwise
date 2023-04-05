import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/db/db_transaction/income_and_expense.dart';
import 'package:wallet_app/models/category/category_model.dart';
import 'package:wallet_app/db/db_transaction/transaction_db.dart';
import 'package:wallet_app/screens/Pie_chart/overAll/graph_over_view.dart';
import 'package:wallet_app/screens/Pie_chart/screen_pie_chart.dart';
import 'package:wallet_app/screens/transaction/add/screen_add_transaction.dart';
import 'package:wallet_app/screens/category/screen_category.dart';
import 'package:wallet_app/screens/settings_screen/settings_screen.dart';
import 'package:wallet_app/screens/transaction/search%20&%20view%20all%20transaction/screen_view_all_and_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      incomeAndExpense();
      overViewGraphNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshTransAndCat();
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
                    height: 80,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const CircleAvatar(
                            child: Icon(Icons.menu),
                          ),
                          onTap: () {
                            return showMenuModalBottomSheet(context);
                          },
                        ),
                        const SizedBox(
                          width: 210,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(40, 0, 7, 72),
                          ),
                          width: 103,
                          height: 35,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'WalletApp',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 7, 72),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    // color: Colors.lightBlue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: totalBalance,
                          builder:
                              (BuildContext ctx, dynamic value, Widget? child) {
                            return Column(
                              children: [
                                totalBalance.value >= 0
                                    ? const Text(
                                        'Balance',
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      )
                                    : const Text(
                                        'Loss',
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                totalBalance.value >= 0
                                    ? Text(
                                        '${totalBalance.value.abs().toString()} ₹',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(210, 0, 7, 72),
                                        ),
                                      )
                                    : Text(
                                        '-${totalBalance.value.abs().toString()} ₹',
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
                      ValueListenableBuilder(
                        valueListenable: incomeTotal,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
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
                                  height: 90,
                                  width: 150,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
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
                                          '${incomeTotal.value} ₹',
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
                      const SizedBox(
                        width: 20,
                      ),
                      ValueListenableBuilder(
                          valueListenable: expenseTotal,
                          builder: (BuildContext context, dynamic value,
                              Widget? child) {
                            return Container(
                              height: 90,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                              ),
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
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
                                      '${expenseTotal.value} ₹',
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
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
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
                              )),
                              const Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: Text(
                                  'Recent Transactions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                // color: Colors.blue,
                              )),
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: SearchWidget());
                                    },
                                    icon: const Icon(Icons.grid_view_rounded),
                                    label: const Text('View all'),
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
                // color: Colors.amber,
                height: 370,
                child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (ctx, newList, Widget? _) {
                    return newList.isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (ctx, index) {
                              final value = newList[index];
                              return Slidable(
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
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: newList.length,
                          )
                        : SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 130),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: FloatingActionButton.extended(
          label: const Text('Add Transaction'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const ScreenAddTransaction()),
              ),
            );
          },
          // backgroundColor: const Color.fromARGB(255, 0, 7, 72),
          // foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }

  void showMenuModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              color: Colors.blueGrey[900],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'WalletApp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const CategoryScreen()))),
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'CATEGORY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((context) => ScreenSettings()),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
