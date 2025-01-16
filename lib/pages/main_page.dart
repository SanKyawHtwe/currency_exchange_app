import 'package:currency_exchange_app/pages/bookmark_page.dart';
import 'package:currency_exchange_app/pages/landing_page.dart';
import 'package:currency_exchange_app/pages/profile_page.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> screenWidgets = [
    const LandingPage(),
    const BookmarkPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      appBar: AppBar(),
      body: screenWidgets[currentIndex],
      bottomNavigationBar: NavigationBar(
          indicatorShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 2,
          height: 58,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          indicatorColor: Theme.of(context).colorScheme.surface,
          selectedIndex: currentIndex,
          onDestinationSelected: (selectedIndex) {
            setState(() {
              currentIndex = selectedIndex;
            });
          },
          destinations: _getBottomNavigationItem()),
    );
  }

  List<NavigationDestination> _getBottomNavigationItem() {
    return [
      NavigationDestination(
          selectedIcon: Icon(
              size: kBottomNavIconSize,
              color: Theme.of(context).colorScheme.inverseSurface,
              CupertinoIcons.arrow_right_arrow_left_circle_fill),
          icon: Icon(
              size: kBottomNavIconSize,
              color: Theme.of(context).colorScheme.surface,
              CupertinoIcons.arrow_right_arrow_left_circle),
          label: "Exchange"),
      NavigationDestination(
          selectedIcon: Icon(
            color: Theme.of(context).colorScheme.inverseSurface,
            size: kBottomNavIconSize,
            Icons.bookmark_outline,
          ),
          icon: Icon(
            color: Theme.of(context).colorScheme.surface,
            size: kBottomNavIconSize,
            Icons.bookmark_outline,
          ),
          label: "Bookmark"),
      NavigationDestination(
          selectedIcon: Icon(
              color: Theme.of(context).colorScheme.inverseSurface,
              size: kBottomNavIconSize,
              CupertinoIcons.person_circle),
          icon: Icon(
              color: Theme.of(context).colorScheme.surface,
              size: kBottomNavIconSize,
              CupertinoIcons.person_circle),
          label: "Profile"),
    ];
  }
}
