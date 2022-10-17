import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_presenter.dart';

class TextFormFieldComponent extends StatelessWidget {
  const TextFormFieldComponent({
    required this.labelText,
    required this.obscureText,
    required this.presenter,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final ILoginPresenter presenter;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      presenter.passwordVisible;
      return TextFormField(
        onChanged: onChanged,
        validator: validator,
        cursorColor: const Color(0XFF1e224c),
        obscureText: obscureText ? presenter.passwordVisible : false,
        decoration: InputDecoration(
          suffixIcon: obscureText
              ? IconButton(
                  onPressed: () {
                    presenter.passwordVisible = !presenter.passwordVisible;
                  },
                  icon: !presenter.passwordVisible
                      ? const Icon(
                          Icons.visibility_off,
                          color: Color(0XFF1e224c),
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Color(0XFF1e224c),
                        ),
                )
              : null,
          suffixIconColor: const Color(0XFF1e224c),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 14, color: Color(0XFF1e224c)),
          contentPadding: const EdgeInsets.only(left: 30),
          hoverColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade100),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade100),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    });
  }
}
