import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnersScreen extends StatelessWidget {
  static const routeName = '/partners';
  const PartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map routeData = ModalRoute.of(context)!.settings.arguments as Map;
    double screenHeight = MediaQuery.of(context).size.height;
    final partnersUrl = '/categories/' + routeData['id'] + '/partners';

    return Scaffold(
        appBar: AppBar(
          title: Text(routeData['title']),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection(partnersUrl).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView(
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 767,
                  childAspectRatio: 7 / 2,
                  crossAxisSpacing: 8,
                ),
                children: snapshot.data!.docs
                    .map((partner) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              routeName,
                              arguments: {
                                // 'dbReference':
                                //     dbReference! + '/' + e.id + routeName!,
                                // 'title': e['title']
                              },
                            );
                          },
                          splashColor: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                          child: Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(screenHeight * 0.1),
                              bottomLeft: Radius.circular(screenHeight * 0.1),
                            )),
                            child: Row(children: [
                              const SizedBox(width: 4),

                              Image(
                                image: NetworkImage(partner['imageUrl']),
                              ),
                              const SizedBox(width: 4),
                              // Text(partner['about'].toString()),
                              Column(
                                  children: partner['about']
                                      .map<Widget>((e) => Text(e + ' '))
                                      .toList())

                              // Text(
                              //   e['title'],
                              //   style: const TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 16,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                            ]),
                          ),
                        ))
                    .toList(),
              );
            }));
  }
}
