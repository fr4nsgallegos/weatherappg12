import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  String hour;
  String temp;
  int isDay;

  ForecastItem({required this.hour, required this.temp, required this.isDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Color(0xff404446),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(4, 5)),
        ],
      ),
      child: Column(
        children: [
          Text(hour, style: TextStyle(color: Colors.white38)),
          SizedBox(height: 8),
          Image.asset(
            "assets/icons/${isDay == 1 ? 'sunny' : 'overcast'}.png",
            height: 50,
          ),
          SizedBox(height: 8),
          Text("$temp°C", style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
