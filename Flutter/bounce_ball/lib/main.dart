import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const BounceBallApp());
}

class BounceBallApp extends StatelessWidget {
  const BounceBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bounce Ball',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BallGameScreen(),
    );
  }
}

class BallGameScreen extends StatefulWidget {
  const BallGameScreen({super.key});

  @override
  State<BallGameScreen> createState() => _BallGameScreenState();
}

class _BallGameScreenState extends State<BallGameScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  // Ball properties
  double _x = 0;
  double _y = 0;
  double _vx = 0;
  double _vy = 0;
  final double _radius = 30;
  final double _gravity = 2000; // pixels per second squared
  final double _restitution = 0.7; // energy loss on bounce (bounciness)
  final double _friction = 0.995; // air resistance

  // Screen size
  Size _screenSize = Size.zero;

  // State
  bool _isDragging = false;
  Duration _lastElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();

    // Initialize position to center after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _screenSize = size;
        _x = size.width / 2;
        _y = size.height / 2;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (_screenSize == Size.zero) return;

    // Calculate dt (delta time) in seconds
    final double dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    // Skip large jumps (e.g. if app was paused) or first frame
    if (dt > 0.1 || dt <= 0) return;

    if (!_isDragging) {
      setState(() {
        // Apply gravity
        _vy += _gravity * dt;

        // Apply friction
        _vx *= _friction;
        _vy *= _friction;

        // Update position
        _x += _vx * dt;
        _y += _vy * dt;

        // Wall collisions
        // Left
        if (_x - _radius < 0) {
          _x = _radius;
          _vx = -_vx * _restitution;
        }
        // Right
        if (_x + _radius > _screenSize.width) {
          _x = _screenSize.width - _radius;
          _vx = -_vx * _restitution;
        }
        // Top
        if (_y - _radius < 0) {
          _y = _radius;
          _vy = -_vy * _restitution;
        }
        // Bottom
        if (_y + _radius > _screenSize.height) {
          _y = _screenSize.height - _radius;
          // If velocity is very low on floor, stop it to prevent jitter
          if (_vy.abs() < _gravity * dt * 5 && _vy > 0) {
            // _vy = 0; // Optional: sticky floor
          }
          _vy = -_vy * _restitution;
        }
      });
    }
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _vx = 0;
      _vy = 0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      // Move the ball with the finger
      // We need to update _x and _y based on the global position of the touch
      // But since the gesture detector is on the ball, details.delta is easier
      _x += details.delta.dx;
      _y += details.delta.dy;

      // Keep within bounds while dragging (optional, but good for UX)
      _x = _x.clamp(_radius, _screenSize.width - _radius);
      _y = _y.clamp(_radius, _screenSize.height - _radius);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      // Set velocity from the throw
      _vx = details.velocity.pixelsPerSecond.dx;
      _vy = details.velocity.pixelsPerSecond.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update screen size in case of resize
    // Note: This might cause a jump if resized, but it's acceptable for this demo
    if (MediaQuery.of(context).size != _screenSize) {
      _screenSize = MediaQuery.of(context).size;
      // Keep ball on screen if resized
      _x = _x.clamp(_radius, _screenSize.width - _radius);
      _y = _y.clamp(_radius, _screenSize.height - _radius);
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Positioned(
            left: _x - _radius,
            top: _y - _radius,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: _radius * 2,
                height: _radius * 2,
                decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan,
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                      offset: Offset(-5, -5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Instructions
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: Text(
                  'Drag and throw the ball!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
