import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Evaluate extends StatelessWidget {
  const Evaluate({Key? key, required this.score, required this.total})
      : super(key: key);
  final int score;
  final int total;
  String feedback(int score, int total) {
    int percentage = (score/total * 100).toInt();
    if (percentage <= 35)
      return "Trẻ nằm trong nhóm nguy cơ cao";
    else if (percentage <= 60)
      return "Trẻ nằm trong nhóm nguy cơ thấp";
    else
      return "Trẻ có sự phát triển bình thường";
  }

  String advices(int score, int total) {
    int percentage = (score/total * 100).toInt();
    if (percentage <= 35)
      return "Bạn nên liên hệ với những cơ sở y tế chuyên môn để khám lại cho trẻ bởi vì trẻ đang có rất nhiều dấu hiệu của rối loạn phát triển ngôn ngữ.";
    else if (percentage <= 60)
      return "Bạn hãy cho trẻ test lại sau 3 tháng.";
    else
      return "Trẻ không có dấu hiệu rối loạn phát triển ngôn ngữ. Nếu bạn vẫn còn lo lắng, hãy cho trẻ test lại sau 6 tháng";
  }

  MaterialColor getProgressColor(score, total) {
    int percentage = (score/total * 100).toInt();
    if (percentage <= 35)
      return Colors.red;
    else if (percentage <= 60)
      return Colors.yellow;
    else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF112D4E),
            title: Text("Kết quả",
                style: TextStyle(
                  fontSize:24.0,
                )
            )
        ),
        body: Scrollbar(
          child: Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CircularPercentIndicator(
                        radius: 180.0,
                        lineWidth: 20.0,
                        percent: score / total,
                        center: Text("${(score/total * 100).toInt()}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                              color: Color.fromARGB(122, 0, 0, 0),
                            )),
                        animation: true,
                        progressColor: getProgressColor(score, total),
                      )),
                  SizedBox(height: 20.0),
                  Center(child:Text(feedback(score, total),
                      style: TextStyle(
                        fontSize: 16.0,
                      ))),
                  SizedBox(height: 20.0),

                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nhận xét chung: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height:6.0),
                            Text("""Trẻ Nguyễn Trung Kiên có sự phát triển bình thường về vốn từ vựng và ngôn ngữ. Điều này có nghĩa là trẻ phát triển tương đương với các trẻ khác ở cùng độ tuổi trong lĩnh vực này."""),
                          ]
                      )
                  ),
                  SizedBox(height:15.0),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gợi ý cho gia đình: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height:6.0),
                            Text("""Gia đình không cần phải lo lắng gì cho trẻ ở thời điểm này. Gia đình tiếp tục cho con giao tiếp, tiếp xúc và xây dựng các kỹ năng cho trẻ để trẻ có sự phát triển tốt nhất.
Trong trường hợp gia đình vẫn còn băn khoăn, lo lắng, gia đình có nothể đưa trẻ đến các cơ sở y tế để trao đổi thêm với cán bộ chuyên môn hoặc có đánh giá chuyên sâu hơn về sự phát triển của trẻ."""),
                          ]
                      )
                  ),
                  SizedBox(height:15.0),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lời khuyên: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height:6.0),
                            Text(advices(score, total)),
                          ]
                      )
                  )
                ],
              )),
        ));
  }
}
