import 'package:currency_exchange_app/pages/onboarding_page.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/images.dart';
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
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: kTitleFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
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
                          "Guest User",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Log in feature is currently unavailable")));
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ))
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Can't edit profile in guest mode!")));
                            },
                            leading: Icon(CupertinoIcons.person),
                            title: Text("My Profile"),
                            trailing: Icon(CupertinoIcons.forward),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Bookmark feature not available for guest mode!")));
                            },
                            leading: Icon(CupertinoIcons.bookmark),
                            title: Text("Bookmarked rates"),
                            trailing: Icon(CupertinoIcons.forward),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Theme.of(context)
                        //           .colorScheme
                        //           .primaryContainer,
                        //       borderRadius: BorderRadius.circular(20)),
                        //   child: ListTile(
                        //     onTap: () {},
                        //     leading: Icon(CupertinoIcons.settings),
                        //     title: Text("Settings"),
                        //     trailing: Icon(CupertinoIcons.forward),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                            title: Text("Log out"),
                            trailing: Icon(CupertinoIcons.forward),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
