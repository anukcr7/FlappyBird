import 'package:flutter/material.dart';

class Mybird extends StatelessWidget {
  final birdy;
  final double birdwidth;
  final double birdHeight;

  Mybird({this.birdy, required this.birdwidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdy + birdHeight) / (2 - birdHeight)),
      child: Image.asset(
        'lib/images/bird.png',
        width: MediaQuery.of(context).size.width * birdwidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
