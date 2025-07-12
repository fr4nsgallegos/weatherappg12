import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg12/services/api_services.dart';
import 'package:weatherappg12/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // VERIFICAMOS QUE EL SERVICIO ESTE HABILITADO
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        print("Los servicios de ubicación estan deshabilitados");
      });
      return;
    }

    // Verificar los permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          print("Permiso de ubicación denegado");
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        print("Los permisos de ubicación estan permanentemente denegados");
      });
      return;
    }

    // obtener la ubicación
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);
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
                getLocation();
              },
              icon: Icon(Icons.location_on_outlined),
              color: Colors.white,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      "Lima, Perú",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 24),
                    Image.asset("assets/icons/heavycloudy.png", height: 100),
                    Text(
                      "23.9 °",
                      style: TextStyle(color: Colors.white, fontSize: 100),
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
                          value: "10",
                          unit: "km/h",
                          image: "windspeed",
                        ),
                        WeatherItem(
                          value: "10",
                          unit: "km/h",
                          image: "humidity",
                        ),
                        WeatherItem(value: "10", unit: "km/h", image: "cloud"),
                      ],
                    ),
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
