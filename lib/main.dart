import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonic Delivery',
      theme: ThemeData(fontFamily: 'Lato').copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.blue,
              secondary: Colors.red,
            ),
      ),
      routes: {
        '/': (context) => const CategoriesScreen(),
        CategoryScreen.routeName: (context) => const CategoryScreen(),
      },
    );
  }
}
