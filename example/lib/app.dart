import 'package:flutter/material.dart';
import 'package:simple_share_example/home.dart';

class SimpleShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        showPerformanceOverlay: false,
        title: 'Simple Share App',
        home: MyHomePage()
    );
  }
}
