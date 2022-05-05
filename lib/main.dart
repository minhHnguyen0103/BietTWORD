import 'package:flutter/material.dart';
import 'package:helloflutter/pages/home.dart';
import 'package:helloflutter/pages/questions.dart';
import 'package:helloflutter/pages/session.dart';
import 'package:helloflutter/pages/evaluate.dart';
import 'package:helloflutter/pages/childlist.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {

    runApp(MaterialApp(
        theme: ThemeData(
            fontFamily: "Cabin",
        ),
        routes: {
            '/': (context) => Home(),
            '/addchild': (context) => Childlist(),
            '/session': (context) => Session(),
            '/questions': (context) => Question(filename: "assets/sltk.txt"),
            '/evaluate': (context) => Evaluate(score: 0, total: 1),
        },
    ));
}


