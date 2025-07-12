import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg12/models/weather_model.dart';

class ApiServices {
  Future<WeatherModel?> getWeatherInfo() async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=Lima&aqi=no",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("----------------------");
      print(response);
      print(response.statusCode);
      print(response.body);
      print("----------------------");
      final data = json.decode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      print(weatherModel);
      print(weatherModel.location.name);
      return weatherModel;
    } else {
      throw Exception("error al cargar: ${response.statusCode}");
    }
  }
}
