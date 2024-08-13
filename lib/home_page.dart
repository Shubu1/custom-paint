import 'dart:math';

import 'package:custom_paint_animation/logicpart/presentation/screens/show_navvar_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  double sliderPosition = 0.3;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 0.0, end: sliderPosition).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      // setState(() {});
      print(_controller.value);
      print(_animation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Assessment',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'How would you rate your fitness level?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Drag to adjust',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 9),
          Stack(
            children: [
              Center(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      // Update the slider position based on the vertical drag
                      sliderPosition -= details.delta.dy / 400;
                      sliderPosition = sliderPosition.clamp(0.0, 1.0);
                    });
                  },
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: CustomPaint(
                      willChange: true,
                      painter: CircularPathPainter(sliderPosition),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 340,
                bottom: sliderPosition *
                    400, // Position the button based on slider position
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      // Update the slider position based on the vertical drag
                      sliderPosition -= details.delta.dy / 400;
                      sliderPosition = sliderPosition.clamp(0.0, 1.0);
                    });
                  },
                  child: AnimatedBuilder(
                    builder: (BuildContext context, _) {
                      return IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.orange),
                        onPressed: () {},
                      );
                    },
                    animation: _controller,
                  ),
                ),
              ),
              const Positioned(
                bottom: 1.0,
                right: 30.0,
                child: Text(
                  'Somewhere Athletic',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowNavBarPage()));
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircularPathPainter extends CustomPainter {
  final double sliderPosition;

  CircularPathPainter(this.sliderPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width, size.height);
    final radius = size.height;

    // Drawing  the quarter circular path based on the slider position
    final path = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        pi, // Start angle (180 degrees, left side)
        sliderPosition * pi / 2, // Sweep angle based on slider position
      );

    final pathPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawPath(path, pathPaint);

    // Drawing the dynamic number at the center of the path
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Mapping the slider position from 0.0-1.0 to 1-10
    final displayValue = (sliderPosition * 9 + 1).round();

    textPainter.text = TextSpan(
      text: '$displayValue', // Display a number from 1 to 10
      style: const TextStyle(
          color: Colors.white, fontSize: 46, fontWeight: FontWeight.bold),
    );

    textPainter.layout();

    final textOffset = Offset(size.width - 200.0, size.height - 80.0);

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
