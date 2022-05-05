import 'package:flutter/material.dart';

class Home extends StatefulWidget {
    const Home({Key? key}) : super(key: key);

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    String _account = "";
    String _password = "";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("BIẾT TWORD",
                    style: TextStyle(
                        fontFamily: "Verdana",
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                    )),
                centerTitle: true,
                backgroundColor: Color(0xFF112D4E),
            ),
            body: Container(
                //Centerlise every widgets within
                color: Color(0xFFF9F7F7),
                margin: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.contain,
                                height: 180.0,
                                width: 180.0,
                            )),
                        buildUsername(),
                        SizedBox(height: 20.0),
                        buildPassword(),
                        SizedBox(height: 20.0),
                        FlatButton(
                            padding: EdgeInsets.fromLTRB(90.0, 20.0, 90.0, 20.0),
                            color: Color(0xFF112D4E),
                            hoverColor: Color(0xFF3F72AF),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                                if (validate(_account, _password)) {
                                    Navigator.pushNamed(context, '/addchild');
                                } else
                                    print("Validation Failed");
                            },
                            child: Text("Đăng nhập",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                )),
                        )
                    ]),
            ),
        );
    }

    Widget buildUsername() => TextFormField(
        decoration: InputDecoration(
            labelText: 'Username',
            border: UnderlineInputBorder(),
        ),
        validator: (value) {
            return null;
        },
        onChanged: (value) => setState(() => _account = value),
    );

    Widget buildPassword() => TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Password',
            border: UnderlineInputBorder(),
        ),
        validator: (value) {
            return null;
        },
        onChanged: (value) => setState(() => _password = value),
    );
}

void hello() {
    print("u clicked me");
}

bool validate(String account, String password) {
    if (account == "admin" && password == "123456")
        return true;
    else
        return false;
}
