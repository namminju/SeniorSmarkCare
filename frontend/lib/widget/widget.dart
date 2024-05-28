/* 버튼 위젯 */
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String navigateTo;
  final ButtonSize size;

  const CustomButton({
    super.key,
    required this.text,
    required this.navigateTo,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    double buttonHeight;
    double buttonWidth;
    double fontSize;

    switch (size) {
      case ButtonSize.small:
        buttonHeight = 40.0;
        buttonWidth = 100.0;
        fontSize = 14.0;
        break;
      case ButtonSize.medium:
        buttonHeight = 50.0;
        buttonWidth = 150.0;
        fontSize = 16.0;
        break;
      case ButtonSize.large:
        buttonHeight = 60.0;
        buttonWidth = 200.0;
        fontSize = 18.0;
        break;
    }

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, navigateTo);
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          textStyle: TextStyle(fontSize: fontSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

enum ButtonSize {
  small,
  medium,
  large,
}
