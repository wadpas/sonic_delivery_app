import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({Key? key}) : super(key: key);

  final titleContr = TextEditingController();
  final dataContr = TextEditingController();
  final amountContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
          actions: [
            IconButton(
              onPressed: () {
                showSheet(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
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
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (contex, index) {
                  var doc = snapshot.data!.docs[index];
                  Timestamp date = doc['date'];
                  double amount = doc['amount'];
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['title'],
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
                              amount.toStringAsFixed(2),
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
                });
          },
        ));
  }

  void submitForm() {
    final titleValue = titleContr.text;
    final amountValue = double.parse(amountContr.text);

    if (titleValue.isEmpty || amountValue <= 0) {
      return;
    }

    FirebaseFirestore.instance
        .collection('/users/Wq1OPs16hutxgwvObhFG/orders')
        .add({
      'title': titleValue,
      'date': DateTime.now(),
      'amount': amountValue
    });
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Card(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: ' Dish'),
                  onSubmitted: (_) => submitForm(),
                  controller: titleContr,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: ' Date'),
                  onSubmitted: (_) => submitForm(),
                  controller: dataContr,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: ' Amount'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitForm(),
                  controller: amountContr,
                ),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Add'),
                )
              ],
            ),
          );
        });
  }
}
