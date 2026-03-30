import 'package:flutter/material.dart';
import 'package:medikto/features/auth/login_view/login_screen.dart';

class AccountCreateSuccess extends StatefulWidget {
  const AccountCreateSuccess({super.key});

  @override
  State<AccountCreateSuccess> createState() => _AccountCreateSuccessState();
}

class _AccountCreateSuccessState extends State<AccountCreateSuccess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/account-create-success.png",
                height: 200,
                width: 240,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              Text(
                "Account Created Successfully",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF181725),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Text(
                "Your Health journey starts here",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7C7C7C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
