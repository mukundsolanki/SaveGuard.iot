import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// ignore: unused_import
import 'dart:convert';
import 'dart:math';
import 'settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(ipAddress: '127.0.0.1',),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String ipAddress;

  MyHomePage({required this.ipAddress});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = 'Loading...';
  List<double> sensorData = [];
  int _currentIndex = 0;

  void updateSensorData(double value) {
    setState(() {
      sensorData.add(value);
    });
  }

  void getStatus() async {
    final Uri url = Uri.parse('http://192.168.246.192:80');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          status = response.body;
        });
      } else {
        setState(() {
          status = 'Establishing the connection...';
        });
      }
    } catch (error) {
      setState(() {
        status = 'Establishing the connection...';
      });
    }
  }

  void getSensorData() async {
    final Uri sensorUrl = Uri.parse('http://192.168.246.192:80/sensor');
    try {
      final response = await http.get(sensorUrl);
      if (response.statusCode == 200) {
        double value = double.parse(response.body);
        updateSensorData(value);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Random random = Random();

  double generateRandomValue(double minValue, double maxValue) {
    return minValue + random.nextDouble() * (maxValue - minValue);
  }

  double generateCarbonMonoOxide() {
    // Typical range for Carbon Mono Oxide: 0 to 0.2 ppm
    return generateRandomValue(0, 0.2);
  }

  double generateMethane() {
    // Typical range for Methane: 1.7 to 2.0 ppm
    return generateRandomValue(1.7, 2.0);
  }

  double generateSmokeConcentration() {
    // Typical range for Smoke Concentration: 1 to 10 ppm
    return generateRandomValue(1, 10);
  }

  double generateAmmoniaSulphur() {
    // Typical range for Ammonia Sulphur: 0.1 to 1 ppm
    return generateRandomValue(0.1, 1);
  }

  void _onBottomNavigationBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }
  }

  @override
  void initState() {
    super.initState();
    // Fetch status every 1 second
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      getStatus();
      getSensorData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        title: Text(
          'SAVE GUARD IOT',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 255, 8),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Colors.black, Color.fromARGB(255, 49, 49, 49)],
          // ),
          color: Color.fromARGB(255,16,38,59),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 350,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Color.fromARGB(255, 171, 171, 171),
                          width: 2.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          status == 'locked'
                              ? Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 180.0,
                                )
                              : Icon(
                                  Icons.lock_open,
                                  color: Color.fromARGB(255, 0, 255, 8),
                                  size: 180.0,
                                ),
                          SizedBox(height: 20.0),
                          Text(
                            status,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 350,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 15, // Set the elevation (shadow) of the card
                    // shadowColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Optional: Set border radius
                      side: BorderSide(
                          // color: Color.fromARGB(255, 171, 171, 171),
                          width: 2.0), // Optional: Set border color and width
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.air,
                          color: Colors.white70,
                          size: 100.0,
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'LPG Concentration:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                '${sensorData.isNotEmpty ? sensorData.last.toStringAsFixed(2) : "N/A"}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Carbon Mono Oxide:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                '${generateCarbonMonoOxide().toStringAsFixed(2)} ppm',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Methane:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                '${generateMethane().toStringAsFixed(2)} ppm',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Smoke Concentration:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                '${generateSmokeConcentration().toStringAsFixed(2)} ppm',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Ammonia Sulphur:',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                '${generateAmmoniaSulphur().toStringAsFixed(2)} ppm',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Color.fromARGB(255, 67, 67, 67),
            labelTextStyle:
                MaterialStatePropertyAll(TextStyle(color: Colors.white))),
        child: NavigationBar(
          backgroundColor: Colors.black,
          // selectedItemColor: Color.fromARGB(255, 65, 227, 168),
          // unselectedItemColor: Colors.white,
          selectedIndex: _currentIndex,
          onDestinationSelected: _onBottomNavigationBarTapped,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              label: 'Home',
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              label: 'About',
              selectedIcon: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
              label: 'Settings',
              selectedIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
