import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallet_wise/provider/category_provider.dart';
import 'package:wallet_wise/provider/transaction_provider.dart';
import 'package:wallet_wise/screens/settings/about/screen_about.dart';
import 'package:wallet_wise/screens/settings/feedback/screen_feedback.dart';
import 'package:wallet_wise/screens/settings/terms%20and%20privacy/screen_terms_and_privacy.dart';
import 'package:wallet_wise/screens/splash/splash_screen.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hsbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 100),
                    const Text(
                      'Settings',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                ),
                const SizedBox(height: 10),
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
                      title: Text('Privacy Policy'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(
                      'https://play.google.com/store/apps/details?id=com.shadu.Walletwise',
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
                const Spacer(),
                const Text(
                  'Walletwise 1.1.0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
