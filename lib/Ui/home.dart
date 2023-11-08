import 'package:flutter/material.dart';
import 'package:weather_app/Ui/components/sevendays_weather.dart';
import 'package:weather_app/Ui/components/todays_weather.dart';
import 'package:weather_app/Ui/components/weather_by_hours.dart';
import 'package:weather_app/api_service/api_service.dart';

import '../api_model/api_model.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _textController = TextEditingController();
  ApiService apiService = ApiService();
  var searchText = "Dhaka";
  chooseCity() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose Location"),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Choose Your City"),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    } else {
                      setState(() {
                        searchText = _textController.text.toString();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Flutter Weather App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              chooseCity();
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
            color: Colors.white,
          ),
        ],
      ),
      body: FutureBuilder(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return Column(
                children: [
                  TodaysWeather(weathermodel: weatherModel),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Weather By Hours",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 150,
                    child: HoursWeather(weatherModel: weatherModel),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NextSevenDaysWeather(
                                    weatherModel: weatherModel)));
                      },
                      child: const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error!!"),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
