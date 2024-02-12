import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/Pages/weather_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  String soilMoistureStatus = '';
  int soilMoistureValue = 0;
  bool waterPumpStatus = false;

  @override
  void initState() {
    super.initState();
    _setUpDatabaseListeners();
  }

  void _setUpDatabaseListeners() {
    _database.child('soil_moister').onValue.listen((event) {
      if (event.snapshot.value != null && event.snapshot.value is Map) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          soilMoistureStatus = values['status'] ?? '';
          soilMoistureValue = values['value'] ?? 0;
          waterPumpStatus = values['water_pumb'] == 'on';
        });
      }
    });
  }

  Color _getProgressColor(int value) {
    if (value >= 0 && value <= 2165) {
      return Colors.green;
    } else if (value > 2165 && value <= 2500) {
      return Colors.yellow;
    } else if (value > 2500 && value <= 3135) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void _toggleWaterPump(bool newValue) {
    _database.child('soil_moister').update({
      'water_pumb': newValue ? 'on' : 'off',
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = soilMoistureValue / 3500.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF164863),
        elevation: 2,
        shadowColor: Colors.black,
        title: Text(
          "Garden Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Check the Weather',
                  style: TextStyle(fontSize: 22, color: Color(0xFF164863)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Soil Moisture Status: $soilMoistureStatus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'Soil Moisture Value: $soilMoistureValue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 25,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(soilMoistureValue),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Water Pump Status: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Switch(
                  value: waterPumpStatus,
                  onChanged: _toggleWaterPump,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
