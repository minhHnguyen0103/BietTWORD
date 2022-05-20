import 'package:flutter/material.dart';
import 'package:helloflutter/pages/questions.dart';

class Session extends StatefulWidget {
  const Session({Key? key}) : super(key: key);

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  int stage = 0;
  int index = 0;
  List<String> guidlines = [
    "Bạn hãy chọn bài test theo thứ tự từ Test ngôn ngữ tiếp nhận → Test ngôn ngữ diễn đạt",
    "Bạn cho trẻ trả lời các câu hỏi và chọn đáp án. Hãy chú ý sau khi đã chọn câu trả lời thì câu hỏi tiếp theo sẽ hiện ra và không thể quay lại câu hỏi trước đó.",
    "Sau khi hoàn thành bài test, hệ thống sẽ đánh giá kết quả. Bạn có thể đọc thêm phần Nhận xét chung và Gợi ý cho gia đình để có thể biết thêm thông tin chi tiết về kết quả và đưa ra những hướng xử lí phù hợp."
  ];
  List<String> imagePaths = [
    "assets/guideImages/guide4.png",
    "assets/guideImages/guide2.jpg",
    "assets/guideImages/guide3.jpg",

  ];
  @override
  Widget build(BuildContext context) {
    if (stage == 0) {
      return Scaffold(
          body: SimpleDialog(
        title: Center(child :Text("Hướng dẫn")),
        contentPadding: EdgeInsets.all(10.0),
        children: <Widget> [
          Image(
            image: AssetImage(imagePaths[index]),
            height: 450.0,
          ),
          SizedBox(height:10.0),
          Center(
              child: Text(guidlines[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                ),
              )
          ),
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          FlatButton(
            onPressed: (index > 0)? () {
              if (index > 0){
              index --;
              setState(() {});}
            } : null,
            child: Text("Prev"),
          ),
          FlatButton(
            onPressed: () {
              index ++;
              if (guidlines.length == index) {
                setState(() {
                  stage = 1;
                });
              }
              else
                setState(() {});
            },
            child: Text("Next"),
          )
        ])],
      ));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF112D4E),
            title: const Text("Bài thi", style: TextStyle(
              fontSize: 24.0,
            )),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(50.0),
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
                            padding: const EdgeInsets.all(30.0),
                            color: const Color(0xFF3F72AF),
                            hoverColor: const Color(0xFF3F72AF),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/questions');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Question(filename: "assets/sltk.txt"),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/img.png"),
                                  height: 150.0,
                                ),
                                SizedBox(height:10.0),
                                Text("Test ngôn ngữ tiếp nhận",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                )),
                              ]
                            )
                      )
                  ),
                  const Expanded(flex: 1, child: SizedBox(width: 1.0)),
                  Expanded(
                      flex: 10,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(30.0),
                        color: const Color(0xFF3F72AF),
                        hoverColor: const Color(0xFF3F72AF),
                        onPressed: () {},
                        child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/images/img_1.png"),
                                height: 150.0,
                              ),
                              SizedBox(height:10.0),
                              Text("Test ngôn ngữ diễn đạt",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  )),
                            ]
                        )
                      )),
                ]),
          ));
    }
  }
}

// class AppGuide extends StatefulWidget {
//   @override
//   _AppGuideState createState() => _AppGuideState();
// }
//
// class _AppGuideState extends State<AppGuide>{
//   @override
//   Widget build(BuildContext context){
//     return AlertDialog(
//       title: Image(
//         image: AssetImage("assets/logo.png"),
//       ),
//       actions: [
//         RaisedButton(onPressed: () {
//           // Navigator.of(context).;
//           Navigator.pushNamed(context, "/session");
//         })
//       ]
//     );
//   }
// }

