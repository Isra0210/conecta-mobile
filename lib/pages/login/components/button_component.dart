import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    required this.buttonText,
    this.isOutilinedButton = true,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool? isOutilinedButton;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: !isOutilinedButton!
            ? null
            : [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isOutilinedButton! ? const Color(0XFF1e224c) : Colors.white,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color:  Color(0XFF1e224c),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: !isOutilinedButton!
                    ? const Color(0XFF1e224c)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
