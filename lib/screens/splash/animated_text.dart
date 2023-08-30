import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextWidget extends StatelessWidget {
  final colorizeColors = [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.yellow,
  ];

  final colorizeTextStyle = const TextStyle(
    fontSize: 38.0,
    fontWeight: FontWeight.w900,
  );
  AnimatedTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'WALLET APP',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          // print("Tap Event");
        },
      ),
    );
  }
}
