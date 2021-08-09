import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sqlite/components/components/widget_list.dart';

import 'weather/select_location.dart';
import 'weather/weather_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var latitude;
  var longitude;
  var temperature;
  var condition;
  var city;

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetList w = WidgetList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profilePage');
                },
                icon: Icon(Icons.radio_button_on))
          ],
        ),
        body: ListView(
          children: w.widgetList,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 5),
                child: GestureDetector(
                  child: Text(
                    'LOCATION',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    // showModalBottomSheet(context: context, builder: buildBottomSheet);
                    getLocation();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => WeatherDetails()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 5),
                child: GestureDetector(
                  child: Text(
                    'SELECT LOCATION',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => SelectLocation()));
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.pop(context);
                },
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'LOG OUT',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    print(longitude);
    print(latitude);
  }
}
