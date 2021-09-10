import 'dart:ui';

import 'package:calculator/components/app_drawer.dart';
import 'package:calculator/helpers/utils.dart';
import 'package:calculator/providers/calculation.dart';
import 'package:calculator/components/calc_button.dart';
import 'package:calculator/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> buttons = [
    'C',
    '⌫',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HistoryScreen(),
              ),
            ),
            icon: Icon(Icons.history),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<Calculation>(
            builder: (context, calculation, child) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        calculation.getCalculation()?.question! ?? '',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: calculation.getCalculation()?.answer != null
                              ? 18.0
                              : 40.0,
                        ),
                      ),
                      if (calculation.getCalculation()?.answer != null)
                        Text(
                          '=${calculation.getCalculation()?.answerDisplay}',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 40.0),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  /// Clear button
                  return CalcButton(
                    onPressed: () => context.read<Calculation>().clear(),
                    color: Colors.blue[900],
                    title: buttons[index],
                  );
                } else if (index == 1) {
                  /// Delete button
                  return CalcButton(
                    onPressed: () => context.read<Calculation>().delete(),
                    color: Colors.blue[900],
                    title: buttons[index],
                  );
                } else if (index == 18) {
                  /// ANS button
                  return CalcButton(
                    onPressed: () {
                      try {
                        context.read<Calculation>().ans();
                      } catch (e) {
                        showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Info'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    color: Colors.blue[900],
                    title: buttons[index],
                  );
                } else if (index == (buttons.length - 1)) {
                  /// Equals button
                  return CalcButton(
                    // onPressed: _onEqualsPressed,
                    onPressed: () => context.read<Calculation>().equals(),
                    color: Colors.orange,
                    title: buttons[index],
                  );
                } else {
                  return CalcButton(
                    onPressed: () =>
                        context.read<Calculation>().add(buttons[index]),
                    color:
                        Utils.isOperator(buttons[index]) ? Colors.orange : null,
                    title: buttons[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
