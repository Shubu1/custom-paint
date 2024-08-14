import 'package:flutter/material.dart';

class ColorBottomNavBar extends StatelessWidget {
  final List<Map<String, dynamic>> colorData;
  final Function(List<String>) onColorSelected;

  const ColorBottomNavBar(
      {super.key, required this.colorData, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                final List<String> colors =
                    List<String>.from(colorData[index]['colors']);
                onColorSelected(colors);
              },
              child: Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: colorData[index]['colors'].length,
                  itemBuilder: (context, colorIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(
                          _parseColor(colorData[index]['colors'][colorIndex]),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int _parseColor(String color) {
    color = color.toUpperCase().replaceAll("#", "");
    if (color.length == 6) {
      color = "FF$color";
    }
    return int.parse(color, radix: 16);
  }
}
