import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';

class PartnersScreen extends StatelessWidget {
  static const routeName = '/partners';
  const PartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partners'),
      ),
      body: const FutureGridView(
        routeName: routeName,
        dbReference: routeName,
      ),
    );
  }
}
