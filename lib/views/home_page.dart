import 'package:flutter/material.dart';
import 'package:division/division.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
          //AppFuncBrowse(),
          HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double value = 0.0;
  bool check = false;
  bool checkcz = false;
  bool checkmenci = false;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(50, 200, 200, 200),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_title(), _homeTop(), _equipment(), _snow()],
          ),
        ));
  }

  _title() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: Text("家庭",
            style: TextStyle(fontSize: 32.0, color: Colors.black87)));
  }

  _homeTop() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Division(
            style: StyleClass()
              ..width(300)
              ..height(150)
              ..elevation(50.0)
              ..backgroundImage(
                  path: "assets/loginSuccess/logo.png", fit: BoxFit.fill)
              ..borderRadius(all: 10.0)
              ..align('top'),
            child: Row(children: <Widget>[_weather(), _temperature()])));
  }

  _weather() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 80),
        child: Row(
          children: <Widget>[
            Division(
                child:
                    Icon(Icons.wb_sunny, size: 32, color: Color(0xFF42526F))),
            Text("晴", style: TextStyle(fontSize: 32.0, color: Colors.black54))
          ],
        ));
  }

  _temperature() {
    return Padding(
        padding: EdgeInsets.fromLTRB(140, 20, 0, 0),
        child: Column(
          children: <Widget>[
            Text("24.6℃",
                style: TextStyle(fontSize: 24.0, color: Colors.lightGreen)),
            Text("室内温度",
                style: TextStyle(fontSize: 10.0, color: Colors.black54))
          ],
        ));
  }

  _equipment() {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
        child: Text("设备",
            style: TextStyle(fontSize: 20.0, color: Colors.black54)));
  }

  _snow() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: 250,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        childAspectRatio: 1.3,
        children: <Widget>[
          Division(
            style: StyleClass()
              ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
              ..borderRadius(all: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/Home/diaodeng.png"),
                Text("客厅吊灯"),
                Switch(
                  value: this.check,
                  onChanged: (bool val) {
                    this.setState(() {
                      this.check = !this.check;
                    });
                  },
                )
              ],
            ),
          ),
          Division(
            style: StyleClass()
              ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
              ..borderRadius(all: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/Home/zldd.png"),
                Text("走廊吊灯"),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 7.5, 0, 0),
                    width: 100,
                    child: Slider(
                      value: value,
                      inactiveColor: Colors.black12,
                      label: 'value: $value',
                      min: 0.0,
                      max: 100.0,
                      divisions: 5,
                      activeColor: Colors.lightGreen,
                      onChanged: (double) {
                        setState(() {
                          value = double.roundToDouble();
                        });
                      },
                    ))
              ],
            ),
          ),
          Division(
            style: StyleClass()
              ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
              ..borderRadius(all: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/Home/cz.png"),
                Text("插座"),
                Switch(
                  value: this.checkcz,
                  onChanged: (bool val) {
                    this.setState(() {
                      this.checkcz = !this.checkcz;
                    });
                  },
                )
              ],
            ),
          ),
          Division(
            style: StyleClass()
              ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
              ..borderRadius(all: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/Home/menci.png"),
                Text("智能门磁"),
                Switch(
                  value: this.checkmenci,
                  onChanged: (bool val) {
                    this.setState(() {
                      this.checkmenci = !this.checkmenci;
                    });
                  },
                )
              ],
            ),
          ),
          Division(
            style: StyleClass()
              ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
              ..borderRadius(all: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/Home/wenshidu.png"),
                Text("温湿度监测"),
                IconButton(icon: Icon(Icons.add), onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }

  _ctest() {
    return Stack(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        Container(
          width: 90,
          height: 90,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
      ],
    );
  }
}
