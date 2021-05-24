import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  static const route = '/home/test_page';
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => TestPage());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page1'),
      ),
    );
  }
}
