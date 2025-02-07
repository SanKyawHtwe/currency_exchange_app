import 'package:currency_exchange_app/data/local/local_data_source.dart';
import 'package:currency_exchange_app/ui/pages/main_page.dart';
import 'package:currency_exchange_app/ui/pages/onboarding_page.dart';
import 'package:currency_exchange_app/utils/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLoggedIn;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool loginStatus = await LocalDataSource.instance.getLoginInfo();

    setState(() {
      isLoggedIn = loginStatus;
    });

    if (isLoggedIn) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainPage()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => OnboardingPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomProgressIndicator(),
    );
  }
}
