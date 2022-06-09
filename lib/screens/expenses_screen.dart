import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

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
              Container(
                width: double.infinity,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Text('Chart'),
                ),
              ),
              ...snapshot.data!.docs
                  .map((e) => Card(
                        child: Text(e['title']),
                      ))
                  .toList()
            ]);
          },
        ));
  }
}
