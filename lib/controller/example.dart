import 'package:flutter/material.dart';
import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  String name;
  String flag;

  Country({
    this.name,
    this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "flag": flag,
  };
}

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Country _selectedValue;
  static String jsonStr = '''
  [
    {"name":"a", "flag":"a1"},
    {"name":"b", "flag":"b1"},
    {"name":"c", "flag":"c1"}
    ]
  ''';
  List<Country> countryList = countryFromJson(jsonStr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: DropdownButton<Country>(
              //isDense: true,
              hint: Text('Choose'),
              value: _selectedValue,
              icon: Icon(Icons.check_circle_outline),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.blue[300],
              ),
              onChanged: (Country newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
              items:
              countryList.map<DropdownMenuItem<Country>>((Country value) {
                return DropdownMenuItem<Country>(
                  value: value,
                  child: Text(value.name + ' ' + value.flag),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}