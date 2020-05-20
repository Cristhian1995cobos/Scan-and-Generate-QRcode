import 'package:flutter/material.dart';

import 'package:start/scan.dart';
import 'package:start/generate.dart';

class HomeScreen extends StatefulWidget{
  @override
   _Home createState() => _Home(); 
 
}

class _Home extends State<HomeScreen> {
  @override 

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("QR SCAN AND GENERATOR"),),
        body: Builder(builder: (BuildContext context) {
          return Container(


            
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => MyApp()),
                    );},
                  child: Text("QR Scan"),
                ),
                RaisedButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Generate()));
                  },
                  child: Text("QR Generate"),
                )
              ]));
        })));
  }
}