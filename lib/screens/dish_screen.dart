import 'package:flutter/material.dart';

class DishScreen extends StatelessWidget {
  static const routeName = '/dish';
  const DishScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dish')),
      body: Container(
        child: Text('Dish'),
      ),
    );
  }
}
