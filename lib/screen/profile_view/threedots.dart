import 'package:flutter/material.dart';

class ThreeDots extends StatefulWidget {
  const ThreeDots({Key? key}) : super(key: key);

  @override
  State<ThreeDots> createState() => _ThreeDotsState();
}

class _ThreeDotsState extends State<ThreeDots>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int inex = 0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds:800))
          ..addStatusListener((status) {
            if (status ==  AnimationStatus.completed) {
              inex++;
              if (inex == 3) {
                inex = 0;
              }
              _animationController!.reset();
              _animationController!.forward();
            }
          });
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Opacity(
                  opacity: index == inex ? 1.0 : 0.2,
                  child: Text(
                    '•',
                    textScaleFactor: 1.5,
                  ));
            }));
      },
    );
  }
}
