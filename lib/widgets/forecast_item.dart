import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({super.key});

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
          Text("02:00", style: TextStyle(color: Colors.white38)),
          SizedBox(height: 8),
          Image.asset("assets/icons/overcast.png", height: 50),
          SizedBox(height: 8),
          Text("5.9°C", style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
