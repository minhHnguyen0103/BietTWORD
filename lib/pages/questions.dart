import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:helloflutter/pages/evaluate.dart';

class Quote {
    String text = "";
    List<String> options = [];
    String answer = "";

    Quote(String text, List<String> options, String answer) {
        this.text = text;
        this.options = options;
        this.answer = answer;
    }
}

class QuoteCard extends StatelessWidget {
    final int index;
    final Quote quote;
    final Function(String) choose;
    QuoteCard({required this.quote, required this.choose, required this.index});

    Widget getOption(String option) {
        if (isPathFile(option)) {
            return Image(
                image: AssetImage(option),
                height: 130,
                width: 130,
            );
        } else {
            return Text(option);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Card(
            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Text(
                            "Câu số ${index}: ${quote.text}",
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Color(0xFF112D4E),
                            ),
                        ),
                        SizedBox(height: 6.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: quote.options.map((option) {
                                return FlatButton(
                                    onPressed: choose(option),
                                    child: getOption(option),
                                );
                            }).toList(),
                        ),
                    ])));
    }
}

class Question extends StatefulWidget {
    const Question({Key? key, required this.filename}) : super(key: key);

    final String filename;
    @override
    _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
    int score = 0;
    int total = 0;
    int index = 1;
    List<Quote> quotes = [];
    String topic = "";
    // List<Quote> quotes = [];
    @override
    initState() {
        super.initState();

        loadData().then((result) {
            setState(() {
                quotes = result;
                total = quotes.length;
                total--;
                print(quotes[0].text);
                topic = quotes[0].answer;
                quotes.removeAt(0);
            });
        });
        // print("Hi thể ");
    }

    loadData() async {
        List<Quote> quests = [];
        String questText = "";
        List<String> options = [];
        String answer = "";

        String response = await rootBundle.loadString(widget.filename);
        List<String> lines = response.split("\n");

        for (var line in lines) {
            if (line.substring(0, 2) == "Q:") {
                if (options.length != 0) {
                    Quote quote = new Quote(questText, List.from(options), answer);
                    quests.add(quote);
                    options.clear();
                }
                questText = line.substring(2);
            } else if (line.substring(0, 2) == "A:") {
                answer = line.substring(2);
            } else {
                options.add(line);
            }
        }

        Quote quote = new Quote(questText, List.from(options), answer);
        quests.add(quote);

        return quests;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFF112D4E),
                title: Text("Chủ đề : $topic"),
                centerTitle: true,
            ),
            body: Column(children: <Widget>[
                SizedBox(height: 20.0),
                QuoteCard(
                    quote: quotes[0],
                    choose: (option) => (() {
                        if (option == quotes[0].answer) score++;
                        quotes.removeAt(0);
                        index ++;
                        if (quotes.length == 0) {
                            // Navigator.pushNamed(context, "/evaluate");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Evaluate(score: score, total: total),
                                ));
                        } else
                            setState(() {
                                if (quotes[0].text == "TOPICCHANGES") {
                                    topic = quotes[0].answer;
                                    //   index --;
                                    total--;
                                    quotes.removeAt(0);
                                }
                            });
                    }),
                    index: index,
                )
            ]),
        );
    }
}

bool isPathFile(String s) {
    String ext = s.split(".").last;
    for (var vext in ["jpeg", "png", "jpg"]) {
        if (vext == ext) return true;
    }
    return false;
}
