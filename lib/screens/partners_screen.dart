import 'package:flutter/material.dart';
import '../widgets/future_grid_view.dart';

class PartnersScreen extends StatelessWidget {
  static const routeName = '/category_screen';
  const PartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map category = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(category['title']),
      ),
      body: FutureGridView(
        reference: '/categories/${category['id']}/partners',
      ),
    );
  }
}
