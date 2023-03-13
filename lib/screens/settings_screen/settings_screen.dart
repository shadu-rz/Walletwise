import 'package:flutter/material.dart';
import 'package:wallet_app/db/db_category/category_db.dart';
import 'package:wallet_app/db/db_transaction/transaction_db.dart';
import 'package:wallet_app/screens/settings_screen/about/screen_about.dart';
import 'package:wallet_app/screens/settings_screen/feedback/screen_feedback.dart';
import 'package:wallet_app/screens/settings_screen/terms%20and%20privacy/screen_terms_and_privacy.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color.fromARGB(255, 0, 7, 72),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ScreenAbout()),
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // print('Feedback send');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenFeedback(),
                  ));
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Feedback'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ScreenTermsAndConditions()),
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.my_library_books),
                    title: Text('Terms and Privacy Policy'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.send),
                    title: Text('Share'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        content: const Text(
                          'Do you want to Delete all data!!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: (() {
                                  CategoryDB.instance.deleteAllCategory();
                                  TransactionDB.instance.deleteAllTransaction();
                                  Navigator.of(context).pop();
                                }),
                                child: const Text(
                                  'yes',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text(
                                  'no',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text(
                      'Delete all data',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'WalletApp',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
