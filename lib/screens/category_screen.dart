import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category_screen';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map categoryData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData['title']),
      ),
      body: Scaffold(
        body: Center(
          child: Text(categoryData['title']),
        ),
      ),
    );
  }
}
