import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  final List<Map<String, Object>> _footballQuestions = [
    {
      'questionText': '1. Which country won the FIFA World Cup in 2018?',
      'answers': [
        {'text': 'Germany', 'score': 0},
        {'text': 'France', 'score': 1},
        {'text': 'Brazil', 'score': 0},
        {'text': 'Argentina', 'score': 0},
      ],
    },
    {
      'questionText':
          '2. Who is the all-time top scorer in the UEFA Champions League?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 0},
        {'text': 'Cristiano Ronaldo', 'score': 1},
        {'text': 'Neymar', 'score': 0},
        {'text': 'Robert Lewandowski', 'score': 0},
      ],
    },
    {
      'questionText':
          '3. Which club has won the most English Premier League titles?',
      'answers': [
        {'text': 'Manchester United', 'score': 1},
        {'text': 'Liverpool', 'score': 0},
        {'text': 'Chelsea', 'score': 0},
        {'text': 'Arsenal', 'score': 0},
      ],
    },
    {
      'questionText': '4. Who won the Ballon d\'Or in 2020?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 1},
        {'text': 'Cristiano Ronaldo', 'score': 0},
        {'text': 'Robert Lewandowski', 'score': 0},
        {'text': 'Neymar', 'score': 0},
      ],
    },
    {
      'questionText': '5. Which country hosted the 2014 FIFA World Cup?',
      'answers': [
        {'text': 'France', 'score': 0},
        {'text': 'Brazil', 'score': 1},
        {'text': 'Germany', 'score': 0},
        {'text': 'Russia', 'score': 0},
      ],
    },
    {
      'questionText': '6. Who is the manager of FC Barcelona?',
      'answers': [
        {'text': 'Pep Guardiola', 'score': 0},
        {'text': 'Zinedine Zidane', 'score': 0},
        {'text': 'Jurgen Klopp', 'score': 0},
        {'text': 'Xavi Hernandez', 'score': 1},
      ],
    },
    {
      'questionText':
          '7. Which player has won the most FIFA Ballon d\'Or awards?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 1},
        {'text': 'Cristiano Ronaldo', 'score': 0},
        {'text': 'Michel Platini', 'score': 0},
        {'text': 'Zinedine Zidane', 'score': 0},
      ],
    },
    {
      'questionText': '8. In which country is the Maracanã Stadium located?',
      'answers': [
        {'text': 'Spain', 'score': 0},
        {'text': 'Italy', 'score': 0},
        {'text': 'Brazil', 'score': 1},
        {'text': 'Argentina', 'score': 0},
      ],
    },
    {
      'questionText': '9. Who won the Golden Boot in the 2018 FIFA World Cup?',
      'answers': [
        {'text': 'Lionel Messi', 'score': 0},
        {'text': 'Cristiano Ronaldo', 'score': 0},
        {'text': 'Kylian Mbappé', 'score': 1},
        {'text': 'Harry Kane', 'score': 0},
      ],
    },
    {
      'questionText':
          '10. Which club has won the most UEFA Champions League titles?',
      'answers': [
        {'text': 'Barcelona', 'score': 0},
        {'text': 'Real Madrid', 'score': 1},
        {'text': 'AC Milan', 'score': 0},
        {'text': 'Bayern Munich', 'score': 0},
      ],
    },
  ];
  void _previousQuestion() {
    if (_questionIndex > 0) {
      setState(() {
        _questionIndex--;
      });
    }
  }

  // void _nextQuestion() {
  //   setState(() {
  //     if (_selectedAnswerIndex != null) {
  //       _selectedAnswerIndex = null;
  //       if (_questionIndex < _footballQuestions.length - 1) {
  //         _questionIndex++;
  //       }
  //     } else {
  //       Text('Please select an answer before moving to the next question.');
  //       // Show a message or perform an action indicating that an answer needs to be selected.
  //       // For now, print a message to the console.
  //       print('Please select an answer before moving to the next question.');
  //     }
  //   });
  // }

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex++;
    });

    if (_questionIndex < _footballQuestions.length) {
      print('More questions available!');
      print('Quiz completed! Your score: $_score');
    } else {
      print('Quiz completed! Your score: $_score');
      // You can add further logic or navigate to a new screen here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Football Quiz'),
      ),
      body: _questionIndex < _footballQuestions.length
          ? FootballQuiz(
              questionIndex: _questionIndex,
              questions: _footballQuestions,
              answerQuestion: _answerQuestion,
              // nextQuestion: _nextQuestion,
              previousQuestion: _previousQuestion,
            )
          : FootballQuizResult(score: _score),
    );
  }
}

class FootballQuiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  // final Function nextQuestion;
  final Function previousQuestion;

  FootballQuiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
    // required this.nextQuestion,
    required this.previousQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'images/quiz.jpg',
                  fit: BoxFit.cover,
                  height: 190,
                  width: double.infinity,
                )),
          ),
          SizedBox(
            height: 12,
          ),
          FootballQuestion(questions[questionIndex]['questionText'] as String),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return FootballAnswer(
              text: answer['text'] as String,
              onPressed: () => answerQuestion(answer['score'] as int),
            );
          }).toList(),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 12,
              ),
              if (questionIndex > 0)
                ElevatedButton(
                  onPressed: () => previousQuestion(),
                  child: Text('Previous'),
                ),
              // if (questionIndex < questions.length - 1)
              //   ElevatedButton(
              //     onPressed: () => nextQuestion(),
              //     child: Text('Next'),
              //   ),
              // if (questionIndex == questions.length - 1)
              //   ElevatedButton(
              //     onPressed: () =>
              //         nextQuestion(), // You can set a default score for skipping
              //     child: Text('Submit'),
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}

class FootballQuestion extends StatelessWidget {
  final String questionText;

  FootballQuestion(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FootballAnswer extends StatelessWidget {
  final String text;
  final Function onPressed;

  FootballAnswer({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: TextStyle(color: Colors.teal),
        ),
      ),
    );
  }
}

class FootballQuizResult extends StatelessWidget {
  final int score;

  FootballQuizResult({required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            'You Scored: $score' + ' out of 10',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
