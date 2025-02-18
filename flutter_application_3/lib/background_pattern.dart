import 'package:flutter/material.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;

  const BackgroundPattern({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.purple.shade100,
            Colors.purple.shade300,
            Colors.purple.shade700,
          ],
          center: Alignment.center,
          radius: 1.5,
        ),
        image: const DecorationImage(
          image: NetworkImage(
            'https://tse1.mm.bing.net/th?id=OIP.SRWZR3d2TiT9UwU0XcDo2QHaEi&pid=Api&P=0&h=180',
          ),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: child,
    );
  }
}
