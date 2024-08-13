import 'package:flutter/material.dart';

class ColorGrid extends StatelessWidget {
  final List<String> colors;

  const ColorGrid({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        scrollDirection: Axis.vertical, // Vertical scrolling for rows
        itemCount: (colors.length / 5).ceil(), // Number of rows
        itemBuilder: (context, rowIndex) {
          final startIndex = rowIndex * 5;
          final endIndex =
              (startIndex + 5) > colors.length ? colors.length : startIndex + 5;
          final rowColors = colors.sublist(startIndex, endIndex);

          return Container(
            height: 60, // Set the height for each row
            child: SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal, // Horizontal scrolling for each row
              child: Row(
                children: rowColors.map((color) {
                  return Container(
                    width: 50, // Width of each color container
                    height: 50, // Height of each color container
                    margin:
                        EdgeInsets.all(4), // Margin around each color container
                    color: Color(int.parse(color.substring(1), radix: 16) +
                        0xFF000000), // Convert hex color string to Color
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
