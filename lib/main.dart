import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input.dart';
import 'convert.dart';
import 'result.dart';
import 'textForm.dart';
import 'riwayat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  TextEditingController suhu = new TextEditingController();

  double _inputUser = 0;
  double _result = 0;
  final inputController = TextEditingController();
  List<String> listItem = ["Kelvin", "Reamur", "Farenheit"];
  List<String> listViewItem = List<String>();
  String _newValue = "Kelvin";

  void hitungSuhu() {
    setState(() {
      _inputUser = double.parse(suhu.text);
      if (_newValue == "Kelvin")
        _result = _inputUser + 273;
      else if (_newValue == "Reamur")
        _result = (4 / 5) * _inputUser;
      else
        _result = (_inputUser * (9 / 5)) + 32;
      listViewItem.add("$_newValue" ":" "$_result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konverter Suhu"),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              textForm(inputController: suhu),
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _newValue,
                onChanged: (String changeValue) {
                  setState(() {
                    _newValue = changeValue;
                    hitungSuhu();
                  });
                },
              ),
              Result(result: _result),
              Convert(convertHandler: hitungSuhu),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Riwayat Konversi",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              riwayat(listViewItem: listViewItem),
            ],
          ),
        ),
      ),
    );
  }
}
