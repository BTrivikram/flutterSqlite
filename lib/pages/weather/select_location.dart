import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'weather_details.dart';

void main() => runApp(MaterialApp());

class SelectLocation extends StatelessWidget {
  var countries;
  var states;
  var city;
  var temper;
  var countryname;
  var statename;
  var cityname;

  List stateList;
  List cityList;
  List countryList;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var countries;
  var states;
  var city;
  var temper;
  var countryname;
  var statename;
  var cityname;

  List stateList;
  List cityList;
  List countryList;

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Select your Country, State and City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //======================================================== State
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: countryname,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select Country'),
                        onChanged: (String newValue) {
                          setState(() {
                            countryname = newValue;
                            getCountry();
                            print(countryname);
                          });
                        },
                        items: countryList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['country_name']),
                                value: item['country_name'].toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: statename,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select State'),
                        onChanged: (String newValue) {
                          setState(() {
                            statename = newValue;
                            getCountry();
                            print(statename);
                          });
                        },
                        items: stateList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['state_name']),
                                value: item['state_name'].toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          // //======================================================== City
          //
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: cityname,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select City'),
                        onChanged: (String newValue) {
                          setState(() {
                            cityname = newValue;
                            print(cityname);
                          });
                        },
                        items: cityList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['city_name']),
                                value: item['city_name'].toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) =>
                          WeatherDetails(cityname: cityname)));
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext=>CityWeatherPage())))
            },
            child: Text("Submit"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  void getCountry() async {
    Response response = await get(
        "https://www.universal-tutorial.com/api/getaccesstoken",
        headers: {
          "Accept": "application/json",
          "api-token":
              "NSHBCDTTw6wQwrgO7eJXkQVJLOv905Z-YK4PxD7LTHvTbfT_I5LtVzsR3f28GAcbdDY",
          "user-email": "trivikramnaik99@gmail.com"
        });

    Response res = await get(
      "https://www.universal-tutorial.com/api/countries/",
      headers: ({
        "Authorization":
            "Trivikram eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfZW1haWwiOiJ0cml2aWtyYW1uYWlrOTlAZ21haWwuY29tIiwiYXBpX3Rva2VuIjoiTlNIQkNEVFR3NndRd3JnTzdlSlhrUVZKTE92OTA1Wi1ZSzRQeEQ3TFRIdlRiZlRfSTVMdFZ6c1IzZjI4R0FjYmREWSJ9LCJleHAiOjE2Mjg1ODE1Nzl9.U3cCqqhrGClPKUnJEcv6P8B3u4L2W4hkNhN-imbSqwA",
        "Accept": "application/json"
      }),
    );

    Response resp = await get(
      "https://www.universal-tutorial.com/api/states/$countryname",
      headers: ({
        "Authorization":
            "Trivikram eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfZW1haWwiOiJ0cml2aWtyYW1uYWlrOTlAZ21haWwuY29tIiwiYXBpX3Rva2VuIjoiTlNIQkNEVFR3NndRd3JnTzdlSlhrUVZKTE92OTA1Wi1ZSzRQeEQ3TFRIdlRiZlRfSTVMdFZ6c1IzZjI4R0FjYmREWSJ9LCJleHAiOjE2Mjg1ODE1Nzl9.U3cCqqhrGClPKUnJEcv6P8B3u4L2W4hkNhN-imbSqwA",
        "Accept": "application/json"
      }),
    );
    Response respo = await get(
      "https://www.universal-tutorial.com/api/cities/$statename",
      headers: ({
        "Authorization":
            "Trivikram eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfZW1haWwiOiJ0cml2aWtyYW1uYWlrOTlAZ21haWwuY29tIiwiYXBpX3Rva2VuIjoiTlNIQkNEVFR3NndRd3JnTzdlSlhrUVZKTE92OTA1Wi1ZSzRQeEQ3TFRIdlRiZlRfSTVMdFZ6c1IzZjI4R0FjYmREWSJ9LCJleHAiOjE2Mjg1ODE1Nzl9.U3cCqqhrGClPKUnJEcv6P8B3u4L2W4hkNhN-imbSqwA",
        "Accept": "application/json"
      }),
    );
    print(response.body);
    print(res.body);

    countryList = jsonDecode(res.body);
    stateList = jsonDecode(resp.body);
    cityList = jsonDecode(respo.body);

    // var data = response.body;
    // var states = resp.body;
    // var city = respo.body;

    setState(() {
      countryList;
      stateList;
      cityList;
    });
  }
}
