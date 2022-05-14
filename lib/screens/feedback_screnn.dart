import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String questions = '/feedback/yIJRWtY6DSOdqRA9hf7T/questions';
  String answers = '/feedback/xAJaFJftAOZozW0vVB3g/answers';
  var questionIndex = 0;
  var estimates = [];
  var suggestion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(questions)
              .orderBy('number')
              .snapshots(),
          builder: (context, qSnapshot) {
            if (qSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var questionList = qSnapshot.data!.docs;
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(answers)
                    .orderBy('rating', descending: true)
                    .snapshots(),
                builder: (context, aSnapshot) {
                  if (aSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var answersList = aSnapshot.data!.docs;
                  return Column(children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(questionList[questionIndex]['text'])),
                    if (questionIndex < questionList.length - 1)
                      Column(
                        children: answersList
                            .map(
                              (answer) => ElevatedButton.icon(
                                icon: Image.network(
                                  answer['imageUrl'],
                                  height: 26,
                                ),
                                label: Text(answer['text']),
                                onPressed: () {
                                  setState(() {
                                    questionIndex += 1;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    if (questionIndex == questionList.length - 1)
                      Column(children: [
                        const TextField(
                          minLines: 2,
                          maxLines: 3,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Send'),
                        ),
                      ]),
                  ]);
                });
          }),
    );
  }
}
