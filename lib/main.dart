import 'package:currency_exchange_app/pages/onboarding_page.dart';
import 'package:currency_exchange_app/providers/currency_provider.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrencyProvider(),
      child: MaterialApp(
        theme: ThemeData(
            canvasColor: Colors.transparent,
            colorScheme: ColorScheme.fromSeed(
                seedColor: kPrimaryColor, brightness: Brightness.light),
            useMaterial3: true,
            fontFamily: kPoppins),
        home: const OnboardingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
