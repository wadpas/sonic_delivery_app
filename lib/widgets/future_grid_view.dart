import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FutureGridView extends StatelessWidget {
  const FutureGridView({
    Key? key,
    this.dbReference,
    this.routeLink,
    this.ratio,
    this.radius,
  }) : super(key: key);
  final String? dbReference;
  final String? routeLink;
  final double? ratio;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(dbReference!).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView(
            padding: const EdgeInsets.all(4),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 767,
              childAspectRatio: ratio!,
              crossAxisSpacing: 8,
            ),
            children: snapshot.data!.docs
                .map((e) => InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routeLink!,
                          arguments: {
                            'dbReference':
                                dbReference! + '/' + e.id + routeLink!,
                            'title': e['title']
                          },
                        );
                      },
                      child: Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(screenHeight * radius!),
                          bottomLeft: Radius.circular(screenHeight * radius!),
                        )),
                        child: Row(children: [
                          // Image(
                          //   image: NetworkImage(e['imageUrl']),
                          // ),
                          const SizedBox(width: 4),
                          Text(
                            e['title'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                    ))
                .toList(),
          );
        });
  }
}
