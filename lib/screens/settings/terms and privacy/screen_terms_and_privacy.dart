import 'package:flutter/material.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for Walletwise App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text('Effective Date: 28/09/2023'),
              SizedBox(height: 20),
              Text(
                'This Privacy Policy explains how Walletwise ("we," "us," or "our") manages information in our Flutter money management app, Walletwise ("the App"). Please carefully review this Privacy Policy before using the App.',
              ),
              SizedBox(height: 20),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Walletwise does not collect or store any personal information, financial data, or personally identifiable information (PII). The App does not access your device\'s internet connection or external servers.',
              ),
              SizedBox(height: 20),
              Text(
                'How We Use Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'As Walletwise does not collect personal information or connect to the internet, we do not use your data for any purpose.',
              ),
              SizedBox(height: 20),
              Text(
                'Data Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We implement reasonable measures to protect the App and any data it may contain. However, since we do not collect or store personal data, the risk associated with data breaches is minimal.',
              ),
              SizedBox(height: 20),
              Text(
                'Third-Party Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Walletwise does not integrate with or use any third-party services, and it does not share any information with third parties.',
              ),
              SizedBox(height: 20),
              Text(
                'Children\'s Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Walletwise is not intended for children under the age of 13, and we do not knowingly collect information from children.',
              ),
              SizedBox(height: 20),
              Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This Privacy Policy may be updated periodically to reflect changes in our practices or for other operational, legal, or regulatory reasons. The date at the beginning of this Privacy Policy will be updated to indicate the last revision date. Your continued use of the App after the revised Privacy Policy has been posted signifies your acceptance of the changes.',
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions or concerns regarding this Privacy Policy or Walletwise, please contact us at mshadulykk777@gmail.com.',
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
