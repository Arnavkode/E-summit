import 'package:flutter/material.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(39, 93, 173, 1),
                  Color.fromRGBO(18, 18, 18, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment(0, -0.5),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 4.0,
              child: Image.asset(
                'lib/assets/images/map.png', // Replace with your map image path
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}