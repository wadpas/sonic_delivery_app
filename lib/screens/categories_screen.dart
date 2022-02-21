import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'partners_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('/categories').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 171,
                  mainAxisSpacing: 8,
                ),
                children: snapshot.data!.docs
                    .map((category) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PartnersScreen.routeName,
                                arguments: {
                                  'id': category.id,
                                  'title': category['title'],
                                });
                          },
                          splashColor: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                          child: Column(children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(category['imageUrl']),
                              ),
                            ),
                            Text(
                              category['title'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        ))
                    .toList(),
              );
            }));
  }
}
