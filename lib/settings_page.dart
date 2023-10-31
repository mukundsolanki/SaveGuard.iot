import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AudioPlayer audioPlayer = AudioPlayer(); // Create class-level variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color.fromARGB(255, 49, 49, 49)],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CircularPercentIndicator(
                        radius: 100,
                        lineWidth: 20,
                        percent: 0.69,
                        progressColor: Color.fromARGB(255, 0, 255, 8),
                        arcType: ArcType.FULL,
                        arcBackgroundColor: Color.fromARGB(255, 54, 54, 54),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '74%',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Air Quality Index: Excellent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    _buildInfoRow("Device Name", "SaveGuard IOT"),
                    _buildInfoRow("Connectivity Status", "Connected"),
                    _buildInfoRow("Device Firmware", "v1.0.0"),
                    _buildInfoRow("IP Address", "192.168.34.70"),
                    _buildInfoRow("MAC Address", "AA:BB:CC:DD:EE:FF"),
                    SizedBox(width: 10),
                    _buildUnlinkButton(),
                    // Add more info rows as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16.0, color: Color.fromARGB(255, 242, 242, 242)),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlinkButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            _playAudioAfterDelay();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: Color.fromARGB(255, 251, 0, 0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.label_important_outline_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  "Activate Smart lock Mode",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _playAudioAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      audioPlayer.play(AssetSource("smoke_alarm.mp3"));
    });
  }
}
