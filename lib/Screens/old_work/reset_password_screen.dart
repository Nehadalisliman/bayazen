/*import 'dart:async';

import 'package:e_learning/Controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '/constants.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();

  // OtpFieldController codeController = OtpFieldController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  ResetPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            const Text(
              'تحقق من رقمك مع الرموز المرسله لك',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: codeController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: conPasswordController,
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Get.to(SignUp());
                      },
                      child: const Text.rich(TextSpan(
                          text: 'لم اتلق الرمز',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '  اعادة الارسال',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            )
                          ])),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    // ignore: deprecated_member_use
                    child: TextButton(
                        onPressed: () async {
                          AuthenticationController().resetPassword(
                              otp: codeController.text,
                              newPassword: passwordController.text,
                              conPassword: conPasswordController.text);
                        },
                        child: const Text(
                          ' تاكيد',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Janna LT Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
