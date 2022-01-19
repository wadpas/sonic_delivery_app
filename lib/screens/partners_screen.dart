import 'package:flutter/material.dart';

import '../widgets/future_grid_view.dart';
import 'items_screen.dart';

class PartnersScreen extends StatelessWidget {
  static const routeName = '/partners';
  const PartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map routeData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeData['title']),
      ),
      body: FutureGridView(
        routeName: ItemsScreen.routeName,
        dbReference: routeData['dbReference'],
      ),
    );
  }
}
