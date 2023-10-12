import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_wise/screens/category/Add%20category%20pop%20up/category_add_popup.dart';
import 'package:wallet_wise/screens/category/expense%20category/expnse_category_list.dart';
import 'package:wallet_wise/screens/category/Income%20category/income_category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/hsbg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screensize.width * 0.05,
                ),
                SizedBox(
                  height: screensize.width * 0.1,
                  width: double.infinity,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      SizedBox(
                        width: screensize.width * 0.05,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 0, 7, 72),
                        ),
                      ),
                      SizedBox(
                        width: screensize.width * 0.15,
                      ),
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 7, 72),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: screensize.width * 0.05,
                ),
                SizedBox(
                  height: screensize.width * 0.1,
                  child: ButtonsTabBar(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 45),
                    backgroundColor: const Color.fromARGB(255, 200, 198, 254),
                    unselectedBackgroundColor: Colors.white54,
                    labelSpacing: 30,
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    tabs: const [
                      Tab(
                        iconMargin: EdgeInsets.all(30),
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Expanded(
                  child: TabBarView(
                    children: [
                      IncomeCategoryList(),
                      ExpenseCategoryList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          showAddCategoryPopup(context);
        },
      ),
    );
  }
}
