
import 'package:flutter/material.dart';

void main() => runApp(const HaftsaraBlog());

class HaftsaraBlog extends StatelessWidget {
  const HaftsaraBlog({super.key});

  @override  
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Hello Iran"),),
      ),
    );
  }
}