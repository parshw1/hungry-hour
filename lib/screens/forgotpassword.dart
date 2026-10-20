import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hungry_hour/utils/text_styles.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Lottie.asset('assets/forget_password.json'),
                SizedBox(height: 20),
                Text(
                  'Forgot Password',
                  style: heading1(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}