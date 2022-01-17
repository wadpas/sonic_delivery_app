import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/categories_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference categories =
        FirebaseFirestore.instance.collection('delivery');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories Screen'),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: categories.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: snapshot.data!.docs
                  .map(
                    (category) => CategoriesItem(key: key, title: category.id),
                  )
                  .toList(),
            );
          },
        ));
  }
}
