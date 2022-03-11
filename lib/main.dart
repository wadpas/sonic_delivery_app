import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/partners_screen.dart';
import 'screens/items_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        appBarTheme: const AppBarTheme().copyWith(
          elevation: 1,
          foregroundColor: Colors.black,
          color: Colors.grey.shade50,
        ),
      ),
      routes: {
        '/': (context) => const PartnersScreen(),
        ItemsScreen.routeName: (context) => const ItemsScreen()
      },
    );
  }
}
