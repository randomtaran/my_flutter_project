import 'package:flutter/material.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    //print(data['isDaytime']);
    //print(data['location']);

    //set background
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.png';
    Color? bgColor = data['isDaytime'] ? Colors.lightBlue : Colors.indigo[700];
    Color? fontColor = data['isDaytime'] ? Colors.black87 : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
           decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location') as Map;
                    if(result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        } as Map;
                      });
                    }
                  },
                  icon: Icon(
                      Icons.edit_location,
                    color: fontColor,
                  ),
                  label: Text(
                      'Edit Location',
                    style: TextStyle(
                      color: fontColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      data['location']!,
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        fontFamily: 'Montserrat',
                        color: fontColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 69.0,
                    fontFamily: 'Montserrat',
                    color: fontColor,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
