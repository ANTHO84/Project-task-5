import 'package:flutter/material.dart';
import 'package:project_task_5/on_hover_test.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
import 'package:confetti/confetti.dart';

final QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizz());

class Quizz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int wrongAnswers = 0;
  int correctAnswers = 0;
  bool isPlaying = false;
  final controller = ConfettiController();

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: 'Kết thúc!',
          desc:
              'Bạn đã hoàn thành bài Quizz.\n Số câu đúng: $correctAnswers / ${correctAnswers + wrongAnswers}',
        ).show();

        if (correctAnswers > wrongAnswers) {
          // pháo hoa
          controller.play();
        }

        quizBrain.reset();
        scoreKeeper = [];
        return;
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          correctAnswers++;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          wrongAnswers++;
        }
        quizBrain.nextQuestion();
      }
    });
  }
bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Stack( //widget xếp chồng
      children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: OnHover(
                builder: (isHovered) {
              return Container(
              child:Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    //The user picked yes.
                    checkAnswer(true);
                  },
                ),
              ),
              );
                }
              )
           
            ),
            Expanded(
              child: OnHover(
                builder: (isHovered) {
                    return Container(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //The user picked no.
                    checkAnswer(false);
                   },
                ),
              ),
              );
                }
              )
           
            ),
            
            Row(
              children: scoreKeeper,
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive, //pháo hoa nổ tung giữa màn hình
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }
}
