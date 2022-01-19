import 'package:flutter/material.dart';

import '../widgets/future_grid_view.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Screen'),
      ),
      body: const FutureGridView(
        reference: '/categories',
      ),
    );
  }
}
