import 'package:flutter/material.dart';

class SearchCityWidget extends StatelessWidget {
  TextEditingController controller;
  VoidCallback function;
  SearchCityWidget({required this.controller, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Ingresa la ciudad",
        filled: true,
        fillColor: Color(0xff404446),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: function,
          icon: Icon(Icons.search_rounded),
          color: Colors.white54,
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "El campo es obligatorio";
        }
        return null;
      },
    );
  }
}
