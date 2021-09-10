import 'package:calculator/providers/calculation.dart';
import 'package:calculator/providers/history.dart';
import 'package:calculator/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<History>(create: (context) => History([])),
        ChangeNotifierProxyProvider<History, Calculation>(
          update: (ctx, history, calculation) => Calculation(
            calculation?.getCalculation(),
            history: history,
          ),
          create: (_) => Calculation(null, history: History([])),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Calculator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              toolbarTextStyle: TextStyle(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
            ),
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
