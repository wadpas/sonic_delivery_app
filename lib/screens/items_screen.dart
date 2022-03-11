import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';

class ItemsScreen extends StatelessWidget {
  static const routeName = '/items';
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map routeData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeData['title']),
      ),
      body: FutureGridView(
        routeName: routeName,
        dbReference: routeData['dbReference'],
      ),
    );
  }
}
