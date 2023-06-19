import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {Key? key,
        required this.label,
        this.buttonWidth = double.infinity,
        this.buttonHeight = 40.0,
        required this.onButtonPressed,
      })
      : super(key: key);
  final String label;
  final double buttonWidth;
  final double buttonHeight;
  final Function onButtonPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          onButtonPressed(context);
        },
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
