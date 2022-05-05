import 'package:flutter/material.dart';
import 'package:helloflutter/pages/questions.dart';

class Session extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF112D4E),
          title: Text("Bài thi", style: TextStyle(
            fontSize: 24.0,
          )),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 10,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                      color: Color(0xFF112D4E),
                      hoverColor: Color(0xFF3F72AF),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/questions');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Question(filename: "assets/sltk.txt"),
                          ),
                        );
                      },
                      child: Text("Test ngôn ngữ tiếp nhận",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          )),
                    )),
                Expanded(flex: 1, child: SizedBox(width: 1.0)),
                Expanded(
                    flex: 10,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                      color: Color(0xFF112D4E),
                      hoverColor: Color(0xFF3F72AF),
                      onPressed: () {},
                      child: Text("Test ngôn ngữ diễn đạt",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          )),
                    )),
              ]),
        ));
  }
}
