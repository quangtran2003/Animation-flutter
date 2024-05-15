// ignore_for_file: library_private_types_in_public_api

import 'package:animation/second_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedContainer Example'),
        ),
        body: const Center(
          child: AnimatedDemo(),
        ),
      ),
    );
  }
}

class AnimatedDemo extends StatefulWidget {
  const AnimatedDemo({super.key});

  @override
  _AnimatedDemoState createState() => _AnimatedDemoState();
}

class _AnimatedDemoState extends State<AnimatedDemo> {
  double? top = 0;
  double? left;
  double? bottom;
  double? right = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AnimatedOpacity(
          opacity: 0.9,
          duration: const Duration(milliseconds: 1000),
          child: Container(
            height: height / 2,
            width: width,
            color: Colors.limeAccent,
            child: Stack(
              children: [
                AnimatedPositioned(
                    curve: Curves.bounceOut,
                    bottom: bottom,
                    top: top,
                    right: right,
                    left: left,
                    duration: const Duration(milliseconds: 500),
                    child: Hero(
                      tag: 'hero',
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.blue,
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBotton(
                    route: 'top',
                    height: height,
                    width: width,
                    icon: Icons.arrow_circle_up_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBotton(
                    route: 'left',
                    height: height,
                    width: width,
                    icon: Icons.arrow_circle_left_outlined),
                _buildBotton(
                    route: 'right',
                    height: height,
                    width: width,
                    icon: Icons.arrow_circle_right_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBotton(
                    route: 'down',
                    height: height,
                    width: width,
                    icon: Icons.arrow_circle_down_outlined),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondScreen()));
            },
            child: const Text('Next Screen'))
      ],
    );
  }

  Widget _buildBotton(
      {IconData icon = Icons.abc,
      required String route,
      double height = 0,
      double width = 0}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (route == 'top') {
            bottom = height / 2 - 80;
            top = 0;
          } else if (route == 'down') {
            top = height / 2 - 80;
            bottom = 0;
          } else if (route == 'right') {
            right = 0;
            left = width - 80;
          } else if (route == 'left') {
            left = 0;
            right = width - 80;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.4)),
        child: Center(child: Icon(icon)),
      ),
    );
  }
}
