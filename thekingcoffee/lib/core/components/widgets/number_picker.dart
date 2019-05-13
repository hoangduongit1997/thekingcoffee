import 'package:flutter/material.dart';
import 'package:thekingcoffee/core/components/lib/number_picker/number_picker.dart';
class Number_Picker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return Number_Picker_Page();
  }

}
class Number_Picker_Page extends State<Number_Picker>{
  int _currentValue = 1;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new NumberPicker.integer(
                  initialValue: _currentValue,
                  minValue: 0,
                  maxValue: 100,
                  onChanged: (newValue) =>
                      setState(() => _currentValue = newValue)),
              new Text("Current number: $_currentValue"),
            ],
          ),
          )
        )
      );

  }
}
