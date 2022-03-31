import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdy = 0;
  double initialPos = birdy;
  double height = 0;
  double gravity = -4.9; //howstrong gravity is
  double velocity = 3.5; //how strong jump is
  double time = 0;
  double birdWidth = 0.1; //out of 2 being entire width and height of screen
  double birdHeight = 0.1;

  bool gamestarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5; //out of 2
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gamestarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdy = initialPos - height;
      });

      //bird dies
      if (birdisdead()) {
        timer.cancel();
        gameover();
      }

      //time going!
      time += 0.1;
    });
  }

  void resetGame() {
    Navigator.pop(context); //alretdialogue dismisses
    setState(() {
      birdy = 0;
      gamestarted = false;
      time = 0;
      initialPos = birdy;
    });
  }

  void gameover() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Center(
              child: Text("G A M E  O V E R",
                  style: TextStyle(color: Colors.brown)),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text("PLAY AGAIN",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdy;
    });
  }

  bool birdisdead() {
    if (birdy < -1 || birdy > 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gamestarted ? jump : startGame,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(0, birdy),
                    color: Colors.yellow,
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    alignment: const Alignment(0, -0.5),
                    child: Text(
                      gamestarted ? '' : 'T A P  T O  P L A Y',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          )
        ],
      )),
    );
  }
}
