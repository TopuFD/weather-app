import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api_model/api_model.dart';

// ignore: must_be_immutable
class NextSevenDaysWeather extends StatelessWidget {
  WeatherModel? weatherModel;
  NextSevenDaysWeather({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: weatherModel?.forecast?.forecastday?.length,
                itemBuilder: (context, index) {
                  Forecastday? forecastday =
                      weatherModel?.forecast?.forecastday?[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black38),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                                "http:${forecastday?.day?.condition?.icon}"),

                            Text(DateFormat.MMMEd().format(DateTime.parse(forecastday?.date??"")),style: const TextStyle(fontSize: 18,color: Colors.white),),
                            Text(forecastday?.day?.condition?.text??"",style: const TextStyle(fontSize: 18,color: Colors.white)),

                            Text("^${forecastday?.day?.maxtempC?.round().toString()}/${forecastday?.day?.mintempC?.round().toString()}",style: const TextStyle(fontSize: 18,color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
