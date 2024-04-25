import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RadialAnimationMenu(
          controller: controller,
        ),
      ),
    );
  }
}

class RadialAnimationMenu extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translate;
  final Animation<double> rotation;

  RadialAnimationMenu({super.key, required this.controller})
      : scale = Tween<double>(begin: 1, end: 0.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.linear),
        ),
        translate = Tween<double>(begin: 0.0, end: 360.8).animate(
          CurvedAnimation(parent: controller, curve: Curves.slowMiddle),
        ),
        rotation = Tween<double>(begin: 0.0, end: 0.8).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.8, curve: Curves.decelerate)));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, index) {
          return Transform.rotate(
            angle: radians(rotation.value),
            child: Stack(
              alignment: Alignment.center,
              children: [
                itemsButton(0, color: Colors.orange, icon: Icons.home),
                itemsButton(45, color: Colors.purple, icon: Icons.shopping_bag),
                itemsButton(90,
                    color: Colors.indigo, icon: Icons.baby_changing_station),
                itemsButton(135, color: Colors.pink, icon: Icons.cabin),
                itemsButton(180, color: Colors.blue, icon: Icons.dangerous),
                itemsButton(225, color: Colors.grey, icon: Icons.e_mobiledata),
                itemsButton(270,
                    color: Colors.deepOrangeAccent, icon: Icons.face),
                itemsButton(310,
                    color: Colors.orange, icon: Icons.g_mobiledata),
                Transform.scale(
                    scale: scale.value - 1.3,
                    child: FloatingActionButton(
                      onPressed: close,
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.cancel_presentation_outlined),
                    )),
                Transform.scale(
                    scale: scale.value,
                    child: FloatingActionButton(
                      onPressed: open,
                      backgroundColor: Colors.blue[100],
                      child: Icon(
                        Icons.stop_circle,
                        size: 30,
                      ),
                    ))
              ],
            ),
          );
        });
  }

  itemsButton(double angle, {required Color color, required IconData icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translate.value) * cos(rad),
          (translate.value) * sin(rad),
        ),
      child: FloatingActionButton(
        onPressed: close,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  open() {
    controller.forward();
  }

  close() {
    controller.reverse();
  }
}
