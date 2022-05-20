import 'package:flutter/material.dart';

class Childlist extends StatefulWidget {

  List<Child> childlist=[];
  @override
  _ChildlistState createState() => _ChildlistState();
}

class _ChildlistState extends State<Childlist> {
  int stage = 0;
  String guidlines =
    "Bạn có thể bấm vào dấu + để thêm thông tin của trẻ. Sau khi hoàn thành điền thông tin, bấm vào Làm bài để bắt đầu bài test";
  String imagePaths =
    "assets/guideImages/guide1.jpg";
  refresh(child) {
    setState(() {
      widget.childlist.add(child);
    });
  }
  @override
  Widget build(BuildContext context) {
    if (stage == 0) {
      return Scaffold( body:SimpleDialog(
        title: Center(child :Text("Hướng dẫn")),
        contentPadding: EdgeInsets.all(10.0),
        children: <Widget> [
          Image(
            image: AssetImage(imagePaths),
            height: 350.0,
          ),
          SizedBox(height:10.0),
          Center(child: Text(guidlines,
            style: TextStyle(
              fontSize: 16.0,
            )
          )),
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                      setState(() {
                        stage = 1;
                      });
                  },
                  child: Text("Đã hiểu"),
                )
              ])],
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF112D4E),
          title: Text("Thông tin của trẻ", style: TextStyle(fontSize: 24.0)),
          centerTitle: true,
        ),
        body:
        Card(
            color: Color(0xFFF9F7F7),
            borderOnForeground: true,
            margin: EdgeInsets.all(20.0),
            child:Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: (widget.childlist.length != 0)? widget.childlist
                    .map((child) => ChildCard(
                    child: child,
                    choose: () {
                      Navigator.pushNamed(context, "/session");
                    }))
                    .toList(): [Text("Hiện chưa có trẻ nào trong danh sách")])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF112D4E),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddChild(childlist: widget.childlist, notifyParent: refresh),
                ));
          },
          child: Icon(Icons.add_outlined),
        ),
      );
    }
  }
}

class AddChild extends StatefulWidget {

  AddChild({Key? key, required this.childlist, required this.notifyParent}) : super(key: key);
  late List<Child> childlist;
  Function(Child) notifyParent;
  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  String _name = "";
  DateTime _birth = DateTime.now();
  bool gender = false;
  String? select="";
  List<String> genderList=["Nam", "Nữ"];
  Map<int, String> mappedGender = ["Nam", "Nữ"].asMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF112D4E),
          title: Text("Điền thông tin"),
          centerTitle: true,
        ),
        body: Container(
            margin: EdgeInsets.all(20.0),
            // shadowColor: Color.fromARGB(255, 130, 129, 131),
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text("Họ và Tên:",
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child:
                      TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            labelText: "Tên trẻ",
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            return null;
                          },
                          onChanged: (value) {
                            _name = value;
                          })),
                  SizedBox(height: 15.0),
                  Text("Ngày sinh: ${_birth.day} tháng ${_birth.month} năm ${_birth.year}",
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  SizedBox(height: 6.0),
                  FlatButton(
                      child: Text("Chọn ngày sinh"),
                      color: Colors.grey[300],
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2010),
                            lastDate: DateTime(2023))
                            .then((date) {
                          setState(() {
                            _birth = date!;
                          });
                        });
                      }),
                  SizedBox(height: 15.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Giới tính: ',
                          style: TextStyle(fontWeight: FontWeight.w400,
                              fontSize:20.0),
                        ),
                        ...mappedGender.entries.map(
                                (MapEntry<int, String> mapEntry) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                    activeColor: Theme.of(context).primaryColor,
                                    groupValue: select,
                                    value: genderList[mapEntry.key],
                                    onChanged: (value) => setState(() => select = value as String?),
                                  ),
                                  Text(mapEntry.value)
                                ]))]),
                  SizedBox(height: 20.0),
                  Center(
                      child:
                      FlatButton(
                        padding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF112D4E),
                        onPressed: () {
                          Child child = new Child(name: _name, birth: _birth, gender: ((select == "Nam")? true: false));
                          widget.notifyParent(child);
                          print("Child added");
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Text("Thêm thông tin",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            )),
                      )),
                ])));
  }
}

void writeChildInfo(String name, DateTime birth, String gender) {
  return null;
}

class Child {
  late String name;
  late DateTime birth;
  late bool gender; // True for female, else male
  // DateTime birth = DateTime.now();

  Child({required this.name, required this.birth, required this.gender});
}

class ChildCard extends StatelessWidget {
  final Child child;
  final Function() choose;
  ChildCard({required this.child, required this.choose});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFFDBE2EF),
        child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            child: Row(children: [
              Expanded(
                  flex: 2,
                  child: CircleAvatar(
                      child: Icon(
                        Icons.account_circle_rounded,
                      ))),
              Expanded(
                  flex: 7,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //   Text("Họ và Tên:"),
                        //   SizedBox(height:6.0),
                        Text("${child.name}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        SizedBox(height: 10.0),
                        Text("Ngày sinh:"),
                        SizedBox(height: 6.0),
                        Text("Ngày ${child.birth.day} tháng ${child.birth.month} năm ${child.birth.year}"),
                        SizedBox(height: 10.0),
                        Text("Giới tính: ${child.gender? "Nam" : "Nữ"}"),
                      ]
                  )),
              Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FlatButton(
                            color: Color(0xFF3F72AF),
                            onPressed: choose,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              children:
                              [
                                Icon(
                                  IconData(0xe800,
                                      fontFamily: "MyFlutterApp",
                                      fontPackage: null
                                  ),
                                  size: 16.0,
                                  color: Color(0xFFFCE38A),
                                ),
                                Text("  Làm bài", style: TextStyle(color: Color(0xFFFCE38A))),
                              ],
                            )
                        )
                      ]
                  ))
            ])));
  }
}


class GenderField extends StatelessWidget {

  final List<String> genderList;

  GenderField(this.genderList);

  @override
  Widget build(BuildContext context) {
    String? select="";
    Map<int, String> mappedGender = genderList.asMap();

    return StatefulBuilder(
      builder: (_, StateSetter setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gender : ',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          ...mappedGender.entries.map(
                (MapEntry<int, String> mapEntry) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: select,
                    value: genderList[mapEntry.key],
                    onChanged: (value) => setState(() => select = value as String?),
                  ),
                  Text(mapEntry.value)
                ]),
          ),
        ],
      ),
    );
  }
}