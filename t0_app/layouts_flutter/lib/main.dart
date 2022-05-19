import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esempio Material App demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Esempio MA'),
        ),
        body: const Center(
          child: Text('Ciao! Io sono un esempio di Material App!'),
        ),
      ),
    );
  }
}
