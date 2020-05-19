import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the screen that you'll see when the app starts
class Generate extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Generate> {
  String _dataString = "Hello from this QR";

  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message =
        // ignore: lines_longer_than_80_chars
        'Hello World ';

    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: myController.text,
            version: QrVersions.auto,
            color: Colors.black,
            emptyColor: Colors.white,
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );
    var inputDecoration = InputDecoration(hintText: message,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 3, style: BorderStyle.solid)),
              );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Generator'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width: 280,
                child: qrFutureBuilder,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:20).copyWith(top:20.0),
            child: TextField(
              decoration: inputDecoration,
              controller: myController,
              onChanged: (value) {
                setState(() {
                  _dataString = myController.text;
                });
              },
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
          //       .copyWith(bottom: 40),
          //   child: Text(_dataString),
          // ),
        ],
      )),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/empty.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
