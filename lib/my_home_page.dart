import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String weatherInfo = "Маалымат жуктолуудо";
  String sityName = "Шаарлар";
  void weatherFun() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=bishkek,&appid=41aa18abb8974c0ea27098038f6feb1b');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      final name = data['name'];
      final temp = data['main']['temp'];
      final weatherKelvin = temp - 273.15;
      setState(() {
        weatherInfo = weatherKelvin.toStringAsFixed(0);
        sityName = name;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO:implement.initState
    weatherFun();
  }

  // @override
  // void dispose() {
  // _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Погода'),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("($sityName шаарындагы температура: $weatherInfo gradus"),
        ]),
      ),
    );
  }
}
