import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Reduced height of the header
      child: Stack(
        children: [
          // Rounded Patterns
          Positioned(
            top: 20,
            left: 30,
            child: _buildDot(40, Colors.purple.withOpacity(0.5)),
          ),
          Positioned(
            bottom: 60,
            right: 200,
            child: _buildDot(50, Colors.pink.withOpacity(0.4)),
          ),
          Positioned(
            top: 60,
            left: 90,
            child: _buildDot(50, Colors.purple.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            child: _buildDot(30, Colors.pink.withOpacity(0.5)),
          ),
          Positioned(
            top: 100,
            left: 150,
            child: _buildDot(30, Colors.purple.withOpacity(0.4)),
          ),
          Positioned(
            bottom: 30,
            right: 80,
            child: _buildDot(40, Colors.purple.withOpacity(0.5)),
          ),
          Positioned(
            top: 30,
            right: 50,
            child: _buildDot(60, Colors.pink.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 10,
            left: 150,
            child: _buildDot(35, Colors.pink.withOpacity(0.4)),
          ),
          Positioned(
            bottom: 5,
            right: 30,
            child: _buildDot(25, Colors.purple.withOpacity(0.5)),
          ),
          // Adjusted Image Position
          Align(
            alignment: Alignment.bottomCenter, // Align image slightly off the edge
            child: ClipRect(
              child: Transform.translate(
                offset: const Offset(-50, -40), // Move slightly left and up
                child: Transform.scale(
                  scale: 2.2, // Enlarge the image
                  child: Image.network(
                    'https://thumbs.dreamstime.com/z/group-girls-hugging-friendship-women-vector-illustration-cartoon-style-group-girls-hugging-115866586.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          // Optional Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.pink.withOpacity(0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
