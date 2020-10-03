import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController inputText = TextEditingController();
  String data;
  String _counter, _value = "";
  //method to scan barcode reader
  Future _incrementCounter() async{
    _counter = await FlutterBarcodeScanner.scanBarcode("#004297", "Cancel", true, ScanMode.QR);
    setState(() {
      _value = _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QR-Code Generator & Scanner",
      home: Scaffold(
        appBar: AppBar(
          title: Text("QR Generator & Scanner"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //------------UI To Generate QR Code------------------//
                      Container(
                        child: Column(
                          children: [
                            data == null
                                ? Container()
                                : Center(
                              child: QrImage(
                                data: "$data ",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter a text",
                                contentPadding: EdgeInsets.all(10),
                              ),
                              controller: inputText,
                            ),
                          ],
                        ),
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          setState(() {
                            data = inputText.text.toString();
                          });
                        },
                        icon: Icon(Icons.qr_code),
                        label: Text("Generate QR Code"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                //------------------UI to Scan QR code ----------------------//
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        _value==null||_value==""||_value=="-1"?"Get QR Scanner Text Here":_value,
                        softWrap: true,
                        style: TextStyle(fontSize: 18),
                      ),
                      RaisedButton.icon(
                        onPressed: _incrementCounter,
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text("QR Code Scanner"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
