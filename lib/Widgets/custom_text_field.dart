import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function? onSubmitted;
  final Widget? suffixIcon;
  final bool? secureText;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextInputAction? textInputAction;
  const CustomTextField(
      {Key? key,
      this.hintText,
      this.controller,
      this.onSubmitted,
      this.validator,
      this.initialValue,
      this.suffixIcon,
      this.secureText,
      this.maxLines,
      this.textInputAction,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      // initialValue: initialValue,
      controller: controller,
      // enabled: true,
      // validator: validator,
      cursorColor: Colors.grey,
      textAlign: TextAlign.right,
      obscureText: secureText ?? false,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChanged,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: textColor,
            fontFamily: 'Janna LT Regular',
          ),
          border: outlineBorder(),
          enabledBorder: outlineBorder(),
          errorBorder: outlineBorder(),
          focusedBorder: outlineBorder(),
          focusedErrorBorder: outlineBorder()),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
