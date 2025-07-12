import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg12/models/forecast_model.dart';
import 'package:weatherappg12/models/weather_model.dart';

class ApiServices {
  Future<WeatherModel?> getWeatherInfoByName(String name) async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$name&aqi=no",
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

  Future<WeatherModel?> getWeatherInfoByPos(double lat, double long) async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$long&aqi=no",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        print(weatherModel);
        print(weatherModel.location.name);
        return weatherModel;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ForecastModel?> getForecastInfoByPos(double lat, double long) async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/forecast.json?key=70866d7ade244a3c9ca20142230509&q=$lat,$long&days=1&aqi=no&alerts=no",
    );
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ForecastModel forecastModel = ForecastModel.fromJson(data);
        print("-------------------------");
        print(forecastModel);
        // print(forecastModel);
        return forecastModel;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
