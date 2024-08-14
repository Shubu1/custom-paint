import 'package:flutter/material.dart';

class ColorGrid extends StatefulWidget {
  final List<String> selectedColors;

  const ColorGrid({super.key, required this.selectedColors});

  @override
  ColorGridState createState() => ColorGridState();
}

class ColorGridState extends State<ColorGrid> {
  List<String> filledColors = [];

  @override
  void didUpdateWidget(ColorGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedColors.isNotEmpty) {
      fillColorsOneByOne(widget.selectedColors);
    }
  }

  void fillColorsOneByOne(List<String> newColors) {
    if (newColors.isNotEmpty) {
      setState(() {
        filledColors.add(newColors.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: (filledColors.length / 5).ceil(), // Number of rows
        itemBuilder: (context, rowIndex) {
          final startIndex = rowIndex * 5;
          final endIndex = (startIndex + 5) > filledColors.length
              ? filledColors.length
              : startIndex + 5;
          final rowColors = List.generate(5, (index) {
            final colorIndex = startIndex + index;
            if (colorIndex < filledColors.length) {
              return Color(
                  int.parse(filledColors[colorIndex].substring(1), radix: 16) +
                      0xFF000000);
            } else {
              return Colors.white;
            }
          });

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(4),
                  color: rowColors[index],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
