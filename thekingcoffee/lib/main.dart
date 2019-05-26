import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        theme: ThemeData(
          primaryColor: Colors.redAccent,
        ),
        title: 'The King Coffee',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          
          body: SplashScreen(),
        ));
  }
}
