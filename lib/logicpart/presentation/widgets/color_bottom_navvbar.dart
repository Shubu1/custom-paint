import 'package:flutter/material.dart';

class ColorBottomNavBar extends StatelessWidget {
  final List<Map<String, dynamic>> colorData;
  final Function(List<String>) onColorSelected; // Expecting List<String>

  ColorBottomNavBar({required this.colorData, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BottomNavigationBar(
        items: colorData.map((data) {
          return BottomNavigationBarItem(
            icon: const Icon(Icons.color_lens, color: Colors.grey),
            label: data['name'],
          );
        }).toList(),
        onTap: (index) {
          final List<String> colors =
              List<String>.from(colorData[index]['colors']);
          onColorSelected(colors); // Passing the list of colors
        },
      ),
    );
  }
}
