import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api_model/api_model.dart';

// ignore: must_be_immutable
class HoursWeather extends StatelessWidget {
  WeatherModel? weatherModel;
  HoursWeather({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length,
        itemBuilder: (context, index) {
          Hour? hour = weatherModel?.forecast?.forecastday?[0].hour?[index];
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(hour?.tempC?.round().toString()??"",style: const TextStyle(color: Colors.white),),
                    ),
                    const Text("o",style: TextStyle(color: Colors.white,fontSize: 10),)
                  ],
                ),
                
                Image.network("http:${hour?.condition?.icon}"),
                
                Text(DateFormat.j().format(DateTime.parse(hour?.time??'')),style: const TextStyle(color: Colors.white),),
              ],
            ),
          );
        });
  }
}
