import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/dish_screen.dart';

class DishesScreen extends StatelessWidget {
  static const routeName = '/dishes';
  const DishesScreen({Key? key}) : super(key: key);
  static const String pushRoute = DishScreen.routeName;

  @override
  Widget build(BuildContext context) {
    final e = ModalRoute.of(context)!.settings.arguments
        as QueryDocumentSnapshot<Object?>;

    return Scaffold(
      appBar: AppBar(
        title: Text(e['title']),
      ),
      body: FutureGridView(
        collectionReference: e.reference.path + routeName,
        pushRoute: pushRoute,
        ratio: 6 / 2,
      ),
    );
  }
}
