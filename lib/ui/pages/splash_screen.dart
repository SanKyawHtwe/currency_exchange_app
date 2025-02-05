import 'package:currency_exchange_app/data/localstorage/local_data_source.dart';
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
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await LocalDataSource.instance.getLoginInfo();

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingPage()),
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
