import 'package:currency_exchange_app/pages/onboarding_page.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/images.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            kProfilePageTitle,
            style: TextStyle(
                fontSize: kTitleFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Profile data

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
                      kUserName,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(kLoginErrorText)));
                        },
                        child: Text(
                          kLoginButtonText,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        ))
                  ],
                ),

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(kEditProfileErrorText)));
                        },
                        leading: Icon(CupertinoIcons.person),
                        title: Text(kMyProfileText),
                        trailing: Icon(CupertinoIcons.forward),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(kBookmarkErrorText)));
                        },
                        leading: Icon(CupertinoIcons.bookmark),
                        title: Text(kBookmarkedRatesText),
                        trailing: Icon(CupertinoIcons.forward),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const OnboardingPage()));
                        },
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: Text(kLogoutButtonText),
                        trailing: Icon(CupertinoIcons.forward),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
