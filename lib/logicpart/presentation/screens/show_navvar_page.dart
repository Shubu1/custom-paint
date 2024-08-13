import 'package:custom_paint_animation/logicpart/data/fetch_json_data.dart';
import 'package:custom_paint_animation/logicpart/presentation/widgets/color_bottom_navvbar.dart';
import 'package:custom_paint_animation/logicpart/presentation/widgets/color_grid.dart';
import 'package:flutter/material.dart';

class ShowNavBarPage extends StatefulWidget {
  const ShowNavBarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowNavBarState createState() => _ShowNavBarState();
}

class _ShowNavBarState extends State<ShowNavBarPage> {
  List<Map<String, dynamic>> colorData = [];
  List<String> selectedColors = [];

  @override
  void initState() {
    super.initState();
    loadColors().then((data) {
      setState(() {
        colorData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Color Picker')),
        bottomNavigationBar: colorData.isEmpty
            ? null
            : ColorBottomNavBar(
                colorData: colorData,
                onColorSelected: (colors) {
                  setState(() {
                    selectedColors = colors;
                  });
                },
              ),
        body: selectedColors.isEmpty
            ? const Center(child: Text('Select a color category'))
            : ColorGrid(colors: selectedColors),
      ),
    );
  }
}
