import 'dart:math';
import 'package:flutter/material.dart';

import 'bell_animations.dart';

void main() {
  runApp(BellAnimationApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CircleAnimationDemo(),
    );
  }
}

class CircleAnimationDemo extends StatefulWidget {
  @override
  _CircleAnimationDemoState createState() => _CircleAnimationDemoState();
}

class _CircleAnimationDemoState extends State<CircleAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bigCircleOpacity;
  late Animation<double> _smallCircleRadius;
  late Animation<double> _smallCircleOpacity;
  late Animation<double> _rightCircleLeftAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _bigCircleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _smallCircleRadius = Tween<double>(begin: 0.0, end: 130.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _smallCircleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _rightCircleLeftAnimation = Tween<double>(begin: 400, end: 280).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Left small circle coming from behind the big circle
                      Positioned(
                        left: 170 +
                            _smallCircleRadius.value * cos(135 * pi / 180) -
                            7.5,
                        top: 180 +
                            _smallCircleRadius.value * sin(135 * pi / 180) -
                            7.5,
                        child: Opacity(
                          opacity: _smallCircleOpacity.value,
                          child: Container(
                            height: 80,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: Colors.red,
                            // ),
                            child: Image.asset(
                              "assets/leaves.png",
                            ),
                          ),
                        ),
                      ),
                      // Top right small circle animating outward from behind the big circle
                      Positioned(
                        left: 170 +
                            _smallCircleRadius.value * cos(315 * pi / 180) -
                            7.5,
                        top: 170 +
                            _smallCircleRadius.value * sin(315 * pi / 180) -
                            7.5,
                        child: Opacity(
                          opacity: _smallCircleOpacity.value,
                          child: Container(
                            height: 80,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: Colors.red,
                            // ),
                            child: Image.asset("assets/leaves.png"),
                          ),
                        ),
                      ),
                      // Right small circle moving from right to its position
                      Positioned(
                        left: _rightCircleLeftAnimation.value,
                        top: 190 - 7.5,
                        child: Opacity(
                          opacity: _smallCircleOpacity.value,
                          child: Container(
                            //width: 15,
                            height: 80,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: Colors.red,
                            // ),
                            child: Image.asset("assets/black_pepper.png"),
                          ),
                        ),
                      ),
                      // Big circle with fading in effect
                      Opacity(
                        opacity: _bigCircleOpacity.value,
                        child: Container(
                          width: 200,
                          height: 200,
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   color: Colors.blue,
                          // ),
                          child: Image.asset(
                            "assets/spaghetti.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startAnimation,
              child: Text("Animate"),
            ),
          ],
        ),
      ),
    );
  }
}
