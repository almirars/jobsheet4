import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input.dart';
import 'convert.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController suhu = new TextEditingController();

  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;
  final inputController = TextEditingController();
  String _newValue = "Kelvin";
  double _result = 0;

  void _hitungSuhu() {
    setState(() {
      _inputUser = double.parse(suhu.text);
      _kelvin = _inputUser + 273;
      _reamur = (4 / 5) * _inputUser;
    });
  }

  var listItem = ["Kelvin", "Reamur"];

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
            children: [
              Input(suhu: suhu),
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: null,
                onChanged: (String changeValue) {
                  setState(() {
                    _newValue = changeValue;
                  });
                },
              ),
              Result(result: _result),
              Convert(konvertHandler: _hitungSuhu),
            ],
          ),
        ),
      ),
    );
  }
}
