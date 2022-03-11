
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() =>runApp(
    MaterialApp(
      title: "Weather App",
      home: Home(),
        debugShowCheckedModeBanner: false

    ),
  );



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  static const apiKey = '???';

  var temp;
  var description;
  var humid; //humidity
  var weather; //currently
  var windSpeed;

  Future getWather () async{
    http.Response response = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=nagoya,jp&lang=ja&units=metric&appid=$apiKey"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.humid = results['main']['humidity'];
      this.weather = results['weather'][0]['main'];
      this.windSpeed = results['wind']['speed'];

    });
  }

  @override
  void initState() {
    super.initState();
    this.getWather();

  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of (context).size.height / 2,
            width: MediaQuery.of (context).size .width,
            color: Colors.red,


      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://www.dreamnews.jp/?action_Image=1&p=0000193107&id=headimage',
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom:20.0,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top:35.0),
                    child: Text(
                      "バンタンテックフォードアカデミーの天気",
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Text(
                  temp!= null ? temp.toString() + "°" : "更新中です",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0),
                  child: Text(
                    weather != null ? weather.toString() : "更新中です",
                    style:TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.thermostat_outlined),
                    title: Text("気温"),
                    trailing: Text(temp != null ? temp.toString() + "°" : "更新中です"),
                  ),
                  ListTile(
                      leading: Icon(Icons.invert_colors),
                      title: Text("湿度"),
                      trailing: Text(humid != null ? humid.toString() : "更新中です"),
                  ),
                  ListTile(
                      leading: Icon(Icons.cloud),
                      title: Text("天気"),
                      trailing: Text(description != null ? description.toString() : "更新中です"),
                  ),
                  ListTile(
                      leading: Icon(Icons.trending_up),
                      title: Text("風速"),
                      trailing: Text(windSpeed != null ? windSpeed.toString() : "更新中です"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}








