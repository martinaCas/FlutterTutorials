import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: const Center(
        child: Text(
          'Ciao, sono un esempio di Non Material App',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 27,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
