import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = 'Loading...';

  void getStatus() async {
    final Uri url = Uri.parse('http://192.168.29.80:5000');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          status = response.body;
        });
      } else {
        setState(() {
          status = 'Error: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        status = 'Error: $error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch status every 1 second (1000 milliseconds)
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      getStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obstacle Status'),
      ),
      body: Center(
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
                    color: Colors.green,
                    size: 180.0,
                  ),
            Text(
              status,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
