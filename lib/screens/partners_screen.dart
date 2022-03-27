import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';
import '../screens/dishes_screen.dart';

class PartnersScreen extends StatelessWidget {
  static const routeName = '/partners';
  const PartnersScreen({Key? key}) : super(key: key);
  static const String pushRoute = DishesScreen.routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partners'),
      ),
      body: const FutureGridView(
        collectionReference: routeName,
        pushRoute: pushRoute,
        ratio: 7 / 2,
      ),
    );
  }
}
