import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Traffic light',
//         home: Scaffold(
//             appBar: AppBar(
//                 title: Text('Traffic light'),
//                 backgroundColor: Colors.teal[300]),
//             body: Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text(
//                       'GO',
//                       style: TextStyle(fontSize: 32, color: Colors.green[500]),
//                     ),
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                       Icon(Icons.circle, size: 100, color: Colors.green[500]),
//                       Icon(Icons.circle, size: 100, color: Colors.orange[100]),
//                       Icon(Icons.circle, size: 100, color: Colors.red[100]),
//                     ])
//                   ]),
//             )));
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int score = 0;
  int tap = 0;

  int _time = 10;
  Timer? _timer;
  int heart = 5;

  bool tapped = false;

  @override
  void initState() {
    _time = 10;
    tap = 0;
    score = 0;
    super.initState();
  }

  void _tap() {
    if (!tapped) {
      heart = 5;
      startTimer();
      tapped = !tapped;
    }
    if (tap < 10) {
      tap++;
    } else {
      tap = 0;
      _time = 10;
      score++;
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_time > 0) {
          _time--;
        } else {
          if (tap < 10) {
            heart--;
          } else {
            score++;
          }
          _time = 10;
          tap = 0;
        }
      });
    });
  }

  IconData setHeart(int order) {
    if (order <= heart) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TapTap',
        home: Scaffold(
            appBar: AppBar(
                title: Center(child: Text('Traffic light')),
                backgroundColor: Colors.teal[400]),
            backgroundColor: Colors.teal[50],
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Score: ' + score.toString(),
                        style: TextStyle(
                            color: Colors.teal[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(setHeart(1), size: 20, color: Colors.red),
                        Icon(setHeart(2), size: 20, color: Colors.red),
                        Icon(setHeart(3), size: 20, color: Colors.red),
                        Icon(setHeart(4), size: 20, color: Colors.red),
                        Icon(setHeart(5), size: 20, color: Colors.red),
                      ],
                    ),
                    Text('Time: ' + _time.toString() + "s",
                        style: TextStyle(
                            color: Colors.red[400],
                            fontStyle: FontStyle.italic,
                            fontSize: 15)),
                    Text('Tap: ' + tap.toString() + "",
                        style:
                            TextStyle(color: Colors.teal[400], fontSize: 15)),
                    ElevatedButton(
                        onPressed: _tap,
                        child: Text('Tap me',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        )),
                  ]),
            )));
  }
}
