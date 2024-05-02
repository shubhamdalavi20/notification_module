import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notification_module/core/screens/home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  const VerifyOtpScreen({super.key, required this.verificationId});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify OTP"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: otpController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                        labelText: "6-Digit OTP", counterText: ""),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      verifyOTP();
                    },
                    color: Colors.blue,
                    child: const Text("Verify"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
