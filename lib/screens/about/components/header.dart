import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/pp.jpg'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Muhamad Bagus Prasetyo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'Flutter Developer',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
