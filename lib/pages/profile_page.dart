import 'package:currency_exchange_app/pages/onboarding_page.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/images.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [kCardGradient1, kCardGradient2, kCardGradient3],
              radius: 3,
              center: Alignment(-1, -1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage(kProfilePlaceHolder),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Guest user",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          FilledButton(
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const OnboardingPage()));
              },
              child: Text("Log out"))
        ],
      ),
    ));
  }
}
