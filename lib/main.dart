import 'package:currency_exchange_app/data/local/hive_local_data_source.dart';
import 'package:currency_exchange_app/data/local/local_data_source.dart';
import 'package:currency_exchange_app/ui/pages/splash_screen.dart';
import 'package:currency_exchange_app/ui/providers/currency_provider.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataSource.instance.initSharePf();
  await HiveLocalDataSource.instance.initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrencyProvider(),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [kCardGradient1, kCardGradient2, kCardGradient3],
            radius: 3,
            center: Alignment(-2, -1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: MaterialApp(
          theme: ThemeData(
              canvasColor: Colors.transparent,
              scaffoldBackgroundColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: kPrimaryColor, brightness: Brightness.light),
              useMaterial3: true,
              fontFamily: kPoppins),
          home: Scaffold(body: SplashScreen()),
          debugShowCheckedModeBanner: true,
        ),
      ),
    );
  }
}
