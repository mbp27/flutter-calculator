import 'package:calculator/providers/calculation.dart';
import 'package:calculator/providers/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: Colors.black)),
        actions: [
          Consumer<History>(
            builder: (context, histories, child) => IconButton(
              onPressed: histories.getHistory().isNotEmpty
                  ? () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete History'),
                          content: Text(
                              'Do you want to delete all calculation history?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                      if (result != null) {
                        if (result) context.read<History>().clear();
                      }
                    }
                  : null,
              icon: Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
      body: Consumer<History>(
        builder: (context, histories, child) => ListView.separated(
          separatorBuilder: (context, index) => Divider(height: 1),
          itemCount: histories.getHistory().length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                context
                    .read<Calculation>()
                    .setCalculation(histories.getHistory()[index]);
                Navigator.of(context).pop();
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              title: Text(
                histories.getHistory()[index].question!,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
              ),
              subtitle: Text(
                '=${histories.getHistory()[index].answerDisplay}',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
