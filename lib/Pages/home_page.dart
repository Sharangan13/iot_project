import 'package:flutter/material.dart';
import 'weather_page.dart'; // Import your WeatherPage file here

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Garden management"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherPage()),
            );
          },
          child: Text('Check the weather'),
        ),
      ),
    );
  }
}
