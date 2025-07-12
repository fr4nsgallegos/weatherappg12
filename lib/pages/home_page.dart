import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg12/models/forecast_model.dart' hide Text, Icon;
import 'package:weatherappg12/models/weather_model.dart';
import 'package:weatherappg12/services/api_services.dart';
import 'package:weatherappg12/widgets/forecast_item.dart';
import 'package:weatherappg12/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // WeatherModel? _forecastModel;
  ForecastModel? _forecastModel;

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // VERIFICAMOS QUE EL SERVICIO ESTE HABILITADO
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("Los servicios de ubicación estan deshabilitados");
      return null;
    }

    // Verificar los permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permiso de ubicación denegado");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Los permisos de ubicación estan permanentemente denegados");
      return null;
    }

    // obtener la ubicación
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print("Error al obtenet ubicación: $e");
      return null;
    }
  }

  Future<void> getWeatherFromPosition() async {
    Position? _pos = await getPosition();

    if (_pos == null) {
      print("No se pudo obtener la ubicación");
      return;
    }

    //RETORNA CORRECTAMENTE LA POSICIÓN DEL DISPOSITIVO
    _forecastModel = await ApiServices().getForecastInfoByPos(
      _pos.latitude,
      _pos.longitude,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWeatherFromPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ApiServices apiServices = ApiServices();
            // apiServices.getWeatherInfoByName("cusco");
            apiServices.getWeatherInfoByPos(
              -8.117676326288677,
              -79.03435342586533,
            );
          },
        ),
        backgroundColor: Color(0xff2C2F31),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff2C2F31),
          title: Text("WeatherApp", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () {
                getPosition().then((value) {
                  print(value);
                });
              },
              icon: Icon(Icons.location_on_outlined),
              color: Colors.white,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _forecastModel == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      // width: double.infinity,
                      // height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff2E5FEC), Color(0xff6B9AF8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${_forecastModel!.location.name}, ${_forecastModel!.location.country}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24),
                          Image.asset(
                            "assets/icons/heavycloudy.png",
                            height: 100,
                          ),
                          Text(
                            "${_forecastModel!.current.tempC} °",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 0.5,
                            indent: 16,
                            endIndent: 16,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WeatherItem(
                                value: _forecastModel!.current.windKph
                                    .toString(),
                                unit: "km/h",
                                image: "windspeed",
                              ),
                              WeatherItem(
                                value: _forecastModel!.current.humidity
                                    .toString(),
                                unit: "%",
                                image: "humidity",
                              ),
                              WeatherItem(
                                value: _forecastModel!.current.cloud.toString(),
                                unit: "%",
                                image: "cloud",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ForecastItem(),
                          ForecastItem(),
                          ForecastItem(),
                          ForecastItem(),
                          ForecastItem(),
                          ForecastItem(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
