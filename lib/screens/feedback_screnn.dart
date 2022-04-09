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
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(questions)
              .orderBy('number')
              .get(),
          builder: (context, qSnapshot) {
            if (qSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var questionList = qSnapshot.data!.docs;
            if (questionIndex == questionList.length - 2) {
              return Column(
                children: [
                  Text(questionList[questionIndex]['text']),
                  const TextField(
                    minLines: 2,
                    maxLines: 3,
                    decoration: InputDecoration(
                      label: Text('Text'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () => questionIndex += 1,
                      );
                    },
                    child: const Text('Send'),
                  )
                ],
              );
            }
            if (questionIndex == questionList.length - 1) {
              return Column(
                children: [
                  Text(questionList[questionIndex]['text']),
                ],
              );
            }
            return Column(children: [
              Text(questionList[questionIndex]['text']),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection(answers)
                    .orderBy('rating', descending: true)
                    .get(),
                builder: (ctx, aSnapshot) {
                  if (aSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: aSnapshot.data!.docs
                        .map(
                          (answer) => ElevatedButton(
                              onPressed: () {
                                estimates.add(answer['rating']);
                                setState(
                                  () => questionIndex += 1,
                                );

                                // FirebaseFirestore.instance
                                //     .collection(questions)
                                //     .doc(question.id)
                                //     .update({
                                //   'estimates': question['estimates'].add('1')
                                // });
                              },
                              child: Text(answer['text'])),
                        )
                        .toList(),
                  );
                },
              )
            ]);
          }),
    );
  }
}
