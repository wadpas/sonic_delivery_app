import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category_screen';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String categoryTitle =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: Scaffold(
        body: Center(child: Text(categoryTitle)),
      ),
    );
  }
}
