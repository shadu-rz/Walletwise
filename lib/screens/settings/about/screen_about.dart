import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Walletwise',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Developed By MOHAMED SHADULI',
                style: TextStyle(fontStyle: FontStyle.italic)),
            Text('Version 1.0.0'),
          ],
        ),
      ),
    );
  }
}
