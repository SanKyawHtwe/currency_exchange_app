import 'package:currency_exchange_app/data/local/auth_service.dart';
import 'package:currency_exchange_app/data/local/local_data_source.dart';
import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/ui/pages/bookmark_page.dart';
import 'package:currency_exchange_app/ui/pages/onboarding_page.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/images.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final local = LocalDataSource();
  final authService = AuthService();
  User? _user;

  Future<void> _getUserInfo() async {
    User? user = await authService.getUser();
    setState(() {
      if (user != null) {
        _user = user;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                      _user?.name ?? 'Guest user',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    _user?.name == null
                        ? OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(kLoginErrorText)));
                            },
                            child: Text(
                              kLoginButtonText,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ))
                        : SizedBox.shrink()
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
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text(kBookmarkErrorText)));
                          Navigator.of((context)).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookmarkPage()));
                        },
                        leading: Icon(CupertinoIcons.bookmark),
                        title: Text(kBookmarkedRatesText),
                        trailing: Icon(CupertinoIcons.forward),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Logging out'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text('Are you sure to log out?'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      local.saveLogoutStatus();
                                      authService.logout();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OnboardingPage()));
                                    },
                                    child: Text(
                                      kLogoutButtonText,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(kLogoutButtonText),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
