import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({Key? key}) : super(key: key);

  final titleContr = TextEditingController();
  final dataContr = TextEditingController();
  final priceContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('/users/Wq1OPs16hutxgwvObhFG/orders')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text('Oops.. Something went wrong.',
                    style: TextStyle(fontSize: 18)),
              );
            }
            return Column(children: [
              ...snapshot.data!.docs.map((e) {
                Timestamp date = e['date'];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e['title'],
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(date.toDate()),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Text(
                            '\$${e['amount']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
              Expanded(child: Container()),
              Card(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: ' Dish'),
                      controller: titleContr,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: ' Date'),
                      controller: dataContr,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: ' Amount'),
                      controller: priceContr,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('/users/Wq1OPs16hutxgwvObhFG/orders')
                            .add({
                          'title': titleContr.text,
                          'date': DateTime.now(),
                          'amount': double.parse(priceContr.text)
                        });
                      },
                      child: const Text('Add'),
                    )
                  ],
                ),
              )
            ]);
          },
        ));
  }
}
