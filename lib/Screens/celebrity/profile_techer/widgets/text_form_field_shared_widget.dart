import 'package:e_learning/Screens/celebrity/profile_techer/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldSharedWidget extends StatelessWidget {
  final String label, hint;
  final String? initialValue;
  final void Function(String) onChanged;
  final String Function(String)? onValidateListenser;
  final TextInputType textType;
  final int maxLines;
  final TextEditingController? controller;
  const TextFormFieldSharedWidget(
      {required this.label,
      required this.hint,
      required this.textType,
      required this.onChanged,
      this.controller,
      this.onValidateListenser,
      this.initialValue,
      Key? key,
      this.maxLines = 1})
      : super(key: key);
  static bool passwordObscure = true;
  static bool passwordVisibilty = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          textAlign: TextAlign.right,
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: textType,
          style: TextStyle(
            fontFamily: appFont,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: textFieldBorder(),
            disabledBorder: textFieldBorder(),
            enabledBorder: textFieldBorder(),
            focusedBorder: textFieldBorder(),
            hintText: hint,
            label: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10.sp,
                fontFamily: appFont,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 13.sp,
              fontFamily: appFont,
              fontWeight: FontWeight.w200,
              color: Colors.grey[900],
            ),
            suffixIcon: label.toLowerCase() == "password"
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                        passwordVisibilty = !passwordVisibilty;
                      });
                    },
                    icon: Icon(
                      passwordVisibilty
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          obscureText:
              label.toLowerCase() == "password" ? passwordObscure : false,
          enabled: true,
        );
      },
    );
  }
}

OutlineInputBorder textFieldBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0.1,
    ),
  );
}
