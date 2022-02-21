import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .doc('/feedback/GCLyb9s9HFbILocnkncx')
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> questions =
                snapshot.data!.data() as Map<String, dynamic>;
            List<String> questionsNames = questions.keys.toList(growable: true);
            print(questions['questions']);
            // print(questions.keys.toList());

            return Column(children: [
              index == 3
                  ? Text('df')
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          index += 1;
                        });
                        print(index);
                      },
                      child: Text('data'))
            ]);
          }),
    );
  }
}
