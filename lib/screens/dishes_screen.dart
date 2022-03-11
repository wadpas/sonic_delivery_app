import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';
import '../screens/dish_screen.dart';

class DishesScreen extends StatelessWidget {
  static const routeName = '/dishes';
  const DishesScreen({Key? key}) : super(key: key);
  static const String routeLink = DishScreen.routeName;

  @override
  Widget build(BuildContext context) {
    final Map routeData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeData['title']),
      ),
      body: FutureGridView(
        routeLink: routeName,
        dbReference: routeData['dbReference'],
        ratio: 6 / 2,
        radius: 0.025,
      ),
    );
  }
}
