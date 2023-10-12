import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_wise/models/category/category_model.dart';
import 'package:wallet_wise/models/transactions/transaction_model.dart';
import 'package:wallet_wise/provider/add_transaction_provider.dart';
import 'package:wallet_wise/provider/category_provider.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/category/Add%20category%20pop%20up/category_add_popup.dart';
import 'package:wallet_wise/screens/home/home_screen.dart';

class ScreenAddTransaction extends StatelessWidget {
  ScreenAddTransaction({super.key});

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false)
          .refreshUiTransaction();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transactions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                await addTransaction(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
              child: const Icon(
                Icons.done,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              //Selected category income or expense
              SizedBox(
                width: double.maxFinite,
                child: Consumer<AddTransactionProvider>(
                    builder: (context, provider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer<AddTransactionProvider>(
                          builder: (context, provider, child) {
                        return ChoiceChip(
                          padding: const EdgeInsets.all(8),
                          label: const Text('Income'),
                          // selected chip value
                          selected: provider.value == 0,
                          // onSelected method
                          onSelected: (bool selected) {
                            provider.incomeChoiceChip();
                          },
                        );
                      }),
                      Consumer<AddTransactionProvider>(
                        builder: (context, provider, child) {
                          return ChoiceChip(
                            padding: const EdgeInsets.all(8),
                            label: const Text('Expense'),
                            // selected chip value
                            selected: provider.value == 1,
                            // onSelected method
                            onSelected: (bool selected) {
                              provider.expenseChoiceChip();
                            },
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(
                height: 20,
              ),

              //category type Dropdown
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 48, 63, 159),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Consumer2<AddTransactionProvider, CategoryProvider>(
                      builder: (context, tProvider, cProvider, _) {
                    return SizedBox(
                      height: screenSize.width * 0.18,
                      width: screenSize.width * 0.7,
                      child: Card(
                        elevation: 3,
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              hint: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Select Category'),
                              ),
                              value: tProvider.categoryID,
                              items: (tProvider.selectedCategoryType ==
                                          CategoryType.income
                                      ? cProvider.incomeCategoryProvider
                                      : cProvider.expenseCategoryProvider)
                                  .map(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.name,
                                    ),
                                    onTap: () {
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .refreshUiCategory();
                                      tProvider.selectedCategoryModel = e;
                                    },
                                  );
                                },
                              ).toList(),
                              onChanged: (selectedValue) {
                                // print(selectedValue);
                                tProvider.categoryID = selectedValue;
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  SizedBox(
                    height: screenSize.width * 0.18,
                    width: screenSize.width * 0.17,
                    child: Card(
                      elevation: 3,
                      child: IconButton(
                        onPressed: () {
                          showAddCategoryPopup(context);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: screenSize.width * 0.02,
              ),

              //Calender select date
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Select date',
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 63, 159),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<AddTransactionProvider>(builder: (context, provider, _) {
                return SizedBox(
                  height: screenSize.width * 0.15,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 3,
                    child: TextButton.icon(
                      onPressed: () async {
                        final selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 35)),
                          lastDate: DateTime.now(),
                        );
                        provider.dateSelection(selectedDateTemp);
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        provider.selectedDate == null
                            ? 'Select Date'
                            : provider.selectedDate.toString().substring(0, 10),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: screenSize.width * 0.02,
              ),

              //purpose

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Notes',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 48, 63, 159)),
                    ),
                  ),
                ],
              ),

              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    autofocus: false,
                    controller: _purposeTextEditingController,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter your Purpose',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.width * 0.03,
              ),

              //amount

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 48, 63, 159),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _amountTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Enter amount',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.width * 0.05,
              ),

              SizedBox(
                height: screenSize.width * 0.02,
              ),
              //submit
              // SizedBox(
              //   width: 500,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       await addTransaction(context);
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => const HomeScreen(),
              //       ));
              //     },
              //     child: const Text('Done'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future addTransaction(context) async {
    final purposeText = _purposeTextEditingController.text;
    final amountText = _amountTextEditingController.text;
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }

    if (Provider.of<AddTransactionProvider>(context, listen: false)
            .selectedDate ==
        null) {
      return;
    }

    if (Provider.of<AddTransactionProvider>(context, listen: false)
            .selectedCategoryModel ==
        null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
      purpose: purposeText,
      amount: parsedAmount,
      date: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedDate,
      type: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedCategoryType!,
      category: Provider.of<AddTransactionProvider>(context, listen: false)
          .selectedCategoryModel!,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    await Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(model);
    Provider.of<TransactionProvider>(context, listen: false)
        .refreshUiTransaction();
    Provider.of<CategoryProvider>(context, listen: false).refreshUiCategory();
    Navigator.of(context).pop();
  }
}
