import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FutureGridView extends StatelessWidget {
  const FutureGridView({Key? key, this.routeName, this.dbReference})
      : super(key: key);
  final String? dbReference;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(dbReference!).get(),
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
                .map((e) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routeName!,
                          arguments: {
                            'dbReference':
                                dbReference! + '/' + e.id + routeName!,
                            'title': e['title']
                          },
                        );
                      },
                      splashColor: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image(
                                image: NetworkImage(e['image']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Text(e['title']),
                        ],
                      ),
                    ))
                .toList(),
          );
        });
  }
}
