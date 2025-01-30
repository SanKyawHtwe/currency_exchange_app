import 'package:currency_exchange_app/pages/main_page.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [kCardGradient1, kCardGradient2, kCardGradient3],
                radius: 3,
                center: Alignment(-2, -1)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 12,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          kAppName,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: kTitleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset(
                          kOnboardingLottie,
                          repeat: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  kOnboardingText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text(kLoginUnavailableText)));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.primary)),
                            child: Text(kLoginButtonText),
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.pushReplacement<void, void>(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const MainPage()));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context)
                                        .colorScheme
                                        .inverseSurface)),
                            child: Text(kGuestLoginButtonText),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
