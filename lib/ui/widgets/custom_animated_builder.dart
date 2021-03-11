import 'package:flutter/material.dart';

class CustomAnimatedBuilder extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> opacity;
  final Widget contentChild;

  CustomAnimatedBuilder({
    this.animationController,
    this.opacity,
    this.contentChild,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: contentChild,
        );
      },
    );
  }
}
