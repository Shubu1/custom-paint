import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, dynamic>>> loadColors() async {
  final jsonString = await rootBundle.loadString('assets/color_data.json');
  final List<dynamic> jsonResponse = json.decode(jsonString);

  List<Map<String, dynamic>> colorData = jsonResponse.map((data) {
    List<String> colors = [
      data['color1'],
      data['color2'],
      data['color3'],
    ];

    colors = colors.map((color) {
      if (!isValidColor(color)) {
        return getRandomColor();
      }
      return color;
    }).toList();

    return {
      'name': data['name'],
      'colors': colors,
    };
  }).toList();

  return colorData;
}

bool isValidColor(String color) {
  return RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color);
}

String getRandomColor() {
  final random = Random();
  return '#${random.nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
