import 'package:calculator/screens/about/about_screen.dart';
import 'package:calculator/screens/primes/primes_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PrimesScreen(),
              ),
            ),
            leading: Icon(
              Icons.format_list_numbered,
              color: Colors.grey,
            ),
            title: Text('Primes'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AboutScreen(),
              ),
            ),
            leading: Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
