import 'package:currency_exchange_app/pages/historical_rates_page.dart';
import 'package:currency_exchange_app/pages/landing_page.dart';
import 'package:currency_exchange_app/pages/profile_page.dart';
import 'package:currency_exchange_app/pages/test_chart.dart';
import 'package:currency_exchange_app/utils/colors.dart';
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
    const TestChart(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [kCardGradient1, kCardGradient2, kCardGradient3],
              radius: 3,
              center: Alignment(-1, -1))),
      child: Scaffold(
        // extendBody: true,
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
      ),
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
            CupertinoIcons.chart_bar_square_fill,
          ),
          icon: Icon(
            color: Theme.of(context).colorScheme.surface,
            size: kBottomNavIconSize,
            CupertinoIcons.chart_bar_square,
          ),
          label: "Historical"),
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
