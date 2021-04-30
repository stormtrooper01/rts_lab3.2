import 'package:flutter/material.dart';
import './Perceptron.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomePage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      PerceptionPage(),
    ];
    return IndexedStack(
      index: page,
      children: pages,
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Лабораторна робота 3.2",
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class PerceptionPage extends StatefulWidget {
  PerceptionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __PerceptionPageState();
  }
}

class __PerceptionPageState extends State<PerceptionPage> {
  double w1;
  double w2;
  int iterations;
  double time;
  var timecount;

  final iterationsTextController = TextEditingController();
  final maxTimeTextController = TextEditingController();
  final learningRateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget getBody() {
    return Center(
      child: ListView
        (children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
        Container(
          width: 300,
          child: TextField(
            controller: iterationsTextController,
            decoration: InputDecoration(
              hintText: 'Кількість ітерацій',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 300,
          child: TextField(
            controller: maxTimeTextController,
            decoration: InputDecoration(
              hintText: 'Часовий дедлайн',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 300,
          child: TextField(
            controller: learningRateTextController,
            decoration: InputDecoration(
              hintText: 'Швидкість навчання',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton.icon(
            label: Text('Порахувати',
            style: new TextStyle(
              fontSize: 20.0,
            ),
            ),
            icon: Icon(Icons.calculate),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              shadowColor: Colors.black26,
              elevation: 5,
            ),
            onPressed: () {
              var timer = Stopwatch();
              timer.start();
              var learningRate = double.parse(learningRateTextController.text);
              var maxTime = double.parse(maxTimeTextController.text);
              var maxIterations = double.parse(iterationsTextController.text);

              var result = new Perceptron(4, learningRate).learn([
                [0, 6],
                [1, 5],
                [3, 3],
                [2, 4]
              ], maxIterations, maxTime);

              setState(() {
                w1 = result[0];
                w2 = result[1];
                time = result[2];
                iterations = result[3];
              });
              timer.stop();
              timecount = timer.elapsedMicroseconds;
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildDialog(context, result, time)
              );
            },
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child:
              Text('W1: ${this.w1 ?? ' '}', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child:
              Text('W2: ${this.w2 ?? ' '}', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Час: ${this.time ?? ' '}',
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Кількість ітерацій: ${this.iterations ?? ' '}',
                  style: TextStyle(fontSize: 20)),
            ),

          ],
        ),
      ]),
    );
  }
}

Widget _buildDialog(BuildContext context, List<num> result, dynamic time) {
  return new AlertDialog(
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(time == null ? '-' : 'Час виконання= $time',
          style: TextStyle(fontSize: 20.0),),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme
            .of(context)
            .primaryColor,
        child: const Text('Закрити',
        style: TextStyle(
          color: Colors.teal,
        )
        ),
      ),
    ],
  );
}
