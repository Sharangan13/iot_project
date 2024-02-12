import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_project/consts.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  List<Weather>? _dailyForecast;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final currentWeather = await _wf.currentWeatherByCityName("jaffna");
    final dailyForecast = await _wf.fiveDayForecastByCityName("jaffna");

    setState(() {
      _weather = currentWeather;
      _dailyForecast = dailyForecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF164863),
          elevation: 2,
          shadowColor: Colors.black, // Small shadow
          title: Text(
            "Weather Data",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white) // Center the title
          ),
      body: SingleChildScrollView(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    if (_weather == null || _dailyForecast == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _locationHeader(),
        SizedBox(height: 5),
        _dateTimeInfo(),
        SizedBox(height: 10),
        _weatherIcon(),
        SizedBox(height: 10),
        _currentTemp(),
        SizedBox(height: 10),
        _extraInfo(),
        SizedBox(height: 10),
        _dailyForecastWidget(),
      ],
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 1),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(
            fontSize: 35,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "  ${DateFormat("d.M.y").format(now)}",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@2x.png",
              ),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF427D9D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoBox(
                icon: Icons.thermostat_outlined,
                label:
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
              ),
              _infoBox(
                icon: Icons.thermostat_outlined,
                label:
                    "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoBox(
                icon: Icons.speed,
                label: "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
              ),
              _infoBox(
                icon: Icons.water_drop_outlined,
                label: "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyForecastWidget() {
    return Column(
      children: [
        Text(
          "Next 5 days forecast",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 120, // Adjust this height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _dailyForecast!.length,
            itemBuilder: (context, index) {
              final weather = _dailyForecast![index];
              return _dailyForecastItem(weather);
            },
          ),
        ),
      ],
    );
  }

  Widget _dailyForecastItem(Weather weather) {
    DateTime date = weather.date!;
    String iconUrl =
        "http://openweathermap.org/img/wn/${weather.weatherIcon}.png";
    String weatherDescription = weather.weatherDescription ?? "";

    // Determine the appropriate icon based on weather conditions
    String iconName;
    if (weatherDescription.toLowerCase().contains('rain')) {
      iconName =
          "http://openweathermap.org/img/wn/09d.png"; // Example: Rain icon
    } else if (weatherDescription.toLowerCase().contains('cloud')) {
      iconName =
          "http://openweathermap.org/img/wn/03d.png"; // Example: Cloud icon
    } else {
      iconName =
          "http://openweathermap.org/img/wn/01d.png"; // Example: Clear sky icon
    }

    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(date),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat("h:mm a").format(date),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              iconName,
              width: 40,
              height: 40,
            ),
            Text(
              "${weather.temperature?.celsius?.toStringAsFixed(0)}° C",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
