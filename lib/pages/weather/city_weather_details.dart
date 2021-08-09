import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import 'dart:convert';

class CityweatherDetails extends StatefulWidget {
  @override
  _CityweatherDetailsState createState() => _CityweatherDetailsState();
}

class _CityweatherDetailsState extends State<CityweatherDetails> {
  var temperature;
  var condition = 'hail';
  var city;
  var latitude;
  var longitude;

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    print(longitude);
    print(latitude);
    getData();
  }

  void getData() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=04a2cee74cd99618dd3dfb2f06de8175';
    Response response = await get(url);
    dynamic data = jsonDecode(response.body);

    // print(data);
    // var all =jsonDecode(data);
    // print(response.body);
    setState(() {
      temperature = data['main']['temp'];
      condition = data['weather'][0]['description'];
      city = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.thermostat,
                    color: Colors.grey,
                  ),
                  Text(
                    'The temperature is',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.teal),
                  )
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    '$temperature',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud,
                    color: Colors.grey,
                  ),
                  Text(
                    'The weather condition is',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.teal),
                  )
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    '$condition',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Text(
                    'You are in',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.teal),
                  )
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    '$city',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
