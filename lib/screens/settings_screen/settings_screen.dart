import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallet_app/provider/category_provider.dart';
import 'package:wallet_app/provider/transaction_provider.dart';
import 'package:wallet_app/screens/settings_screen/about/screen_about.dart';
import 'package:wallet_app/screens/settings_screen/feedback/screen_feedback.dart';
import 'package:wallet_app/screens/settings_screen/terms%20and%20privacy/screen_terms_and_privacy.dart';
import 'package:wallet_app/screens/splash/splash_screen.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                        builder: ((context) =>
                            const ScreenTermsAndConditions()),
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
                  onTap: () {
                    Share.share(
                      'https://play.google.com/store/apps/details?id=com.shadu.walletapp',
                    );
                  },
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
                          backgroundColor: Colors.red,
                          content: const Text(
                            'Do you want to Delete all data!!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: (() {
                                    // CategoryDB.instance.deleteAllCategory();
                                    Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .deleteAllCategory();
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .deleteAllTransaction();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SpalshScreen(),
                                        ),
                                        (route) => false);
                                  }),
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: (() {
                                    Navigator.of(context).pop();
                                  }),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
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
                  child: const Card(
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text(
                        'Reset App',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.38,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
      ),
    );
  }
}
