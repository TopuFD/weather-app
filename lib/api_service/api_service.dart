import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/constant/constant.dart';
import '../api_model/api_model.dart';

class ApiService {
  Future<WeatherModel?> getWeatherData(String searchText) async {
    final url = "$baseUrl&q=$searchText&days=7";
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weathermodel = WeatherModel.fromJson(json);
        return weathermodel;
      } else {
        throw "respons is not found";
      }
    } catch (e) {
      throw e;
    }
  }
}
