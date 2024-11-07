import 'package:flutter/material.dart';

class BellAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Bell Animation')),
        body: Center(child: BellAnimation()),
      ),
    );
  }
}

class BellAnimation extends StatefulWidget {
  @override
  _BellAnimationState createState() => _BellAnimationState();
}

class _BellAnimationState extends State<BellAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the controller and set a duration for the animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define the rotation animation from -15 to +15 degrees to create the ringing effect
    _rotationAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.15), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.15, end: -0.15), weight: 1),
    ]).animate(_controller);

    // Loop the animation back and forth for continuous ringing effect
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Icon(Icons.notifications, size: 100, color: Colors.orange),
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: child,
        );
      },
    );
  }
}
