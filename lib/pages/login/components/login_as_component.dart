import 'package:flutter/material.dart';

import '../../../utils/get_snack_bar.dart';

class LoginAsComponent extends StatelessWidget {
  const LoginAsComponent({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        getSnackBar(
          context,
          title: 'Ops!',
          message: 'Função não implementada!',
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
              color: Colors.white,
          
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
            ),
            child: Image.asset(imagePath, width: 35),
          ),
        ),
      ),
    );
  }
}
