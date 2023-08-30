import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

// ignore: must_be_immutable
class ScreenFeedback extends StatelessWidget {
  // const ScreenFeedback({super.key});

  final _key = GlobalKey<FormState>();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  ScreenFeedback({super.key});

  sendEmail(String body) async {
    final Email email = Email(
      body: body,
      subject: 'Feedback',
      recipients: ['mshadulykk76@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.width * 0.05,
                  ),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: screenSize.width * 0.5,
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: body,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Your Feedback Here',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.width * 0.05,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        _key.currentState!.save();

                        sendEmail(
                          body.text,
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(210, 0, 7, 72),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
