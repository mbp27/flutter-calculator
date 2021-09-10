import 'package:calculator/components/calc_button.dart';
import 'package:calculator/models/primes.dart' as model;
import 'package:calculator/providers/focus_primes.dart';
import 'package:calculator/providers/primes.dart';
import 'package:flutter/material.dart' hide Focus;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrimesScreen extends StatefulWidget {
  const PrimesScreen({Key? key}) : super(key: key);

  @override
  _PrimesScreenState createState() => _PrimesScreenState();
}

class _PrimesScreenState extends State<PrimesScreen> {
  final List<String> buttons = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    'C',
    '0',
    '⌫'
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FocusPrimes>(
            create: (context) => FocusPrimes(Focus.start)),
        ChangeNotifierProxyProvider<FocusPrimes, Primes>(
          update: (ctx, focusPrimes, primes) => Primes(
            primes!.getPrimes(),
            focusPrimes: focusPrimes,
          ),
          create: (_) => Primes(
            model.Primes(
              start: 0,
              end: 0,
              result: [0],
            ),
            focusPrimes: FocusPrimes(Focus.start),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Primes', style: TextStyle(color: Colors.black)),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer2<FocusPrimes, Primes>(
                  builder: (context, focusPrimes, primes, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   focus = Focus.start;
                          // });
                          focusPrimes.setFocusPrimes(Focus.start);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Start',
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${primes.getPrimes().start}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: focusPrimes.getFocusPrimes() ==
                                            Focus.start
                                        ? Theme.of(context).primaryColor
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   focus = Focus.end;
                          // });
                          focusPrimes.setFocusPrimes(Focus.end);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'End',
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${primes.getPrimes().end}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: focusPrimes.getFocusPrimes() ==
                                            Focus.end
                                        ? Theme.of(context).primaryColor
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onLongPress: () async {
                          await Clipboard.setData(ClipboardData(
                            text: '${primes.getPrimes().result.join(', ')}',
                          )).then(
                            (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text('Result copied to clipboard'),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Result',
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${primes.getPrimes().result.join(', ')}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.6,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    /// Clear button
                    return CalcButton(
                      onPressed: () => context.read<Primes>().clear(),
                      color: Colors.blue[900],
                      title: buttons[index],
                    );
                  } else if (index == (buttons.length - 1)) {
                    /// Delete button
                    return CalcButton(
                      onPressed: () => context.read<Primes>().delete(),
                      color: Colors.blue[900],
                      title: buttons[index],
                    );
                  } else {
                    return CalcButton(
                      onPressed: () =>
                          context.read<Primes>().add(buttons[index]),
                      title: buttons[index],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
