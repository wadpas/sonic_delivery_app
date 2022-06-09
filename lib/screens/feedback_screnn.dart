import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var _questionIndex = 0;
  final _estimates = [];
  final _suggestion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/feedback').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text('Oops.. Something went wrong.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
          }
          var questions = snapshot.data!.docs[1].data() as Map;
          var answers = snapshot.data!.docs[0].data() as Map;
          return Column(children: [
            Container(
                margin: const EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: Text(
                  questions[_questionIndex.toString()],
                  style: const TextStyle(fontSize: 20),
                )),
            if (_questionIndex < questions.length - 1)
              ...answers.entries
                  .toList()
                  .reversed
                  .map(
                    (answer) => ElevatedButton.icon(
                      icon: Image.network(answer.value['img'], width: 28),
                      label: SizedBox(
                        width: 76,
                        child: Text(
                          answer.value['text'],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _questionIndex += 1;
                        });
                        _estimates.add(int.parse(answer.key) + 1);
                      },
                    ),
                  )
                  .toList(),
            if (_questionIndex == questions.length - 1)
              Column(children: [
                const TextField(
                  minLines: 2,
                  maxLines: 3,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _questionIndex = 0;
                    });
                  },
                  child: const Text('Send'),
                ),
                Text(_estimates.toString()),
                Text(_suggestion)
              ]),
          ]);
        },
      ),
    );
  }
}
