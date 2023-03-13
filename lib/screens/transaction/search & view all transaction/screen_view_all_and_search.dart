import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/db/db_transaction/transaction_db.dart';
import 'package:wallet_app/screens/transaction/edit/screen_edit_transaction.dart';
import 'package:wallet_app/screens/transaction/search%20&%20view%20all%20transaction/date_range_widget.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transactions/transaction_model.dart';

var filterListner = TransactionDB.instance.transactionFilterNotifier;

class SearchWidget extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // DateTimeRange? selectedDateRange;

    return [
      IconButton(
        icon: const Icon(
          Icons.clear_rounded,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      ),
      PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () async {
                await TransactionDB.instance.refresh();
              },
              child: const Text('All'),
            ),
            PopupMenuItem(
              onTap: () async {
                await TransactionDB.instance.refresh();
                filterListner.value = TransactionDB
                    .instance.transactionFilterNotifier.value
                    .where((element) =>
                        element.date.day == DateTime.now().day &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
              child: const Text('Today'),
            ),
            PopupMenuItem(
              onTap: () async {
                await TransactionDB.instance.refresh();
                filterListner.value = TransactionDB
                    .instance.transactionFilterNotifier.value
                    .where((element) =>
                        element.date.day == DateTime.now().day - 1 &&
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
              child: const Text('Yesterday'),
            ),
            PopupMenuItem(
              onTap: () async {
                await TransactionDB.instance.refresh();
                filterListner.value = TransactionDB
                    .instance.transactionFilterNotifier.value
                    .where((element) =>
                        element.date.month == DateTime.now().month &&
                        element.date.year == DateTime.now().year)
                    .toList();
              },
              child: const Text('This month'),
            ),
            PopupMenuItem(
              onTap: () async {
                await TransactionDB.instance.refresh();
                filterListner.value = TransactionDB
                    .instance.transactionFilterNotifier.value
                    .where((element) =>
                        element.date.isAfter(
                            first!.subtract(const Duration(days: 1))) &&
                        element.date
                            .isBefore(second!.add(const Duration(days: 1))))
                    .toList();
              },
              child: const WidgetDateRange(),
            ),
          ];
        },
        icon: const Icon(
          Icons.calendar_today_rounded,
          color: Color.fromARGB(255, 0, 7, 72),
        ),
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () async {
              await TransactionDB.instance.refresh();
            },
            child: const Text('All'),
          ),
          PopupMenuItem(
            onTap: () async {
              await TransactionDB.instance.refresh();
              filterListner.value = TransactionDB
                  .instance.transactionFilterNotifier.value
                  .where((element) => element.type == CategoryType.income)
                  .toList();
            },
            child: const Text('Income'),
          ),
          PopupMenuItem(
            onTap: () async {
              await TransactionDB.instance.refresh();
              filterListner.value = TransactionDB
                  .instance.transactionFilterNotifier.value
                  .where((element) => element.type == CategoryType.expense)
                  .toList();
            },
            child: const Text('Expense'),
          ),
        ],
        icon: const Icon(
          Icons.sort,
          color: Color.fromARGB(255, 0, 7, 72),
        ),
      ),
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                content: const Text(
                  'Clear all Transactions !?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          TransactionDB.instance.deleteAllTransaction();
                          Navigator.of(context).pop();
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
        },
        icon: const Icon(Icons.delete_forever),
        color: Colors.red[700],
      )
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filterListner,
      builder: ((ctx, newList, Widget? _) {
        return ListView.builder(
          itemBuilder: ((context, index) {
            final value = newList[index];
            final editValue = TransactionModel(
              id: value.id,
              purpose: value.purpose,
              amount: value.amount,
              date: value.date,
              type: value.type,
              category: value.category,
              notes: value.notes,
            );
            if (value.category.toString().toLowerCase().contains(
                      query.toLowerCase().trim(),
                    ) ||
                value.purpose
                    .toLowerCase()
                    .trim()
                    .contains(query.toLowerCase().trim()) ||
                value.amount.toString().contains(
                      query.trim(),
                    )) {
              return Slidable(
                key: Key(value.id!),
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
                            builder: ((context) => ScreenEditTransaction(
                                  transactionObj: editValue,
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        TransactionDB.instance
                                            .deleteTransaction(value.id!);
                                        Navigator.of(context).pop();
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
                child: SingleChildScrollView(
                  child: Card(
                    color: value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: ListTile(
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
                              color: Colors.white,
                            ),
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
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(left: 100),
                            width: double.maxFinite,
                            // color: Colors.amber,
                            child: Text(
                              'Notes : ${value.notes}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
          itemCount: newList.length,
        );
      }),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filterListner,
      builder: ((ctx, newList, Widget? _) {
        return ListView.builder(
          itemBuilder: ((context, index) {
            final value = newList[index];
            final editValue = TransactionModel(
              id: value.id,
              purpose: value.purpose,
              amount: value.amount,
              date: value.date,
              type: value.type,
              category: value.category,
              notes: value.notes,
            );
            if (value.category.toString().toLowerCase().contains(
                      query.toLowerCase().trim(),
                    ) ||
                value.purpose
                    .toLowerCase()
                    .trim()
                    .contains(query.toLowerCase().trim()) ||
                value.amount.toString().contains(
                      query.trim(),
                    )) {
              return Slidable(
                key: Key(value.id!),
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
                            builder: ((context) => ScreenEditTransaction(
                                  transactionObj: editValue,
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        TransactionDB.instance
                                            .deleteTransaction(value.id!);
                                        Navigator.of(context).pop();
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
                child: SingleChildScrollView(
                  child: Card(
                    color: value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: ListTile(
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
                              color: Colors.white,
                            ),
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
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(left: 100),
                            width: double.maxFinite,
                            // color: Colors.amber,
                            child: Text(
                              'Notes : ${value.notes}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
          itemCount: newList.length,
        );
      }),
    );
  }

  String parseDate(DateTime date) {
    final dateS = DateFormat.MMMd().format(date);
    final splitedDate = dateS.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}
