# Safeguard.IoT

## Overview

Safeguard.IoT is a home security system that utilizes IR sensors, MQ2 gas sensors, and the ESP32 development board to provide real-time monitoring of door status and gas levels. The system includes an Android application developed with Flutter, enabling users to remotely check the status of their doors and monitor gas levels using their smartphones. The project also integrates Firebase for real-time data storage.

## Features

- ### Door Lock System: 

    Uses an IR sensor to determine if the door is locked or not. When the security system is activated, any unauthorized door opening triggers an alert to notify the user.

- ### Gas Monitoring: 
    Incorporates an MQ2 gas sensor to detect LPG leakage and monitor various other gases, ensuring a safer environment.

- ### Android Application: 
    The Flutter-based mobile application allows users to connect with the Safeguard.IoT device, providing real-time updates on door status and gas levels.

- ### ESP32 and Firebase Integration: 
    Utilizes the ESP32 development board to gather sensor data and Firebase for seamless real-time data storage.


## Hardware Requirements

- EPS32 Development Board
- MQ2 Sensor
- IR Sensor
- Jumper Wires

## Hardware Connections

- MQ-2 Sensor:
    
    ```
    VCC --> 5V of ESP32
    GND --> GND
    A0  --> D35
    ```

- IR Sensor:

    ```
    VCC --> 3V of ESP32
    GND --> GND
    OUT --> D2
    ```

## Installation and Setup

- ### 1.Clone the Repository:
```
git clone https://github.com/mukundsolanki/SaveGuard.iot.git
```

- ### 2. Configure Firebase:

    - Create a Firebase project and obtain the necessary credentials.
    - Update the Firebase configuration in the Arduino code.

- ### 3. Build and Deploy:

    - Upload the Arduino code to the ESP32 board.
    - Build and deploy the Flutter app to your Android device.

- ### 4.Run the System:

    - Power up the Safeguard.IoT system.
    - Open the mobile app and connect to the device using the IP Address of ESP32

## License:

This project is licensed under the MIT License.