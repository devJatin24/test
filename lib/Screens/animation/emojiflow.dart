import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EmojiAnimation extends StatefulWidget {
  const EmojiAnimation({Key? key}) : super(key: key);

  @override
  _EmojiAnimationState createState() => _EmojiAnimationState();
}

class _EmojiAnimationState extends State<EmojiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late double right;
  late int randomSize;
  late double opacity;

  late Size size;
  late EdgeInsets _viewInsets;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initializeValue();
    super.initState();
  }

  void _initializeValue() {
    right = math.Random().nextInt(20).toDouble();
    randomSize = math.Random().nextInt(18);
    opacity = 0.90;
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    beginAnimation(animationController);
  }

  beginAnimation(AnimationController controller) {
    controller.forward().whenComplete(() {
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _viewInsets = MediaQuery.of(context).viewInsets;
    return AnimationBody();
  }

  Widget AnimationBody() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, snapshot) {
          final value = animationController.value;
          double? bottom = lerpDouble(
              _viewInsets.bottom + 50, _viewInsets.bottom + size.height, value);
          opacity = lerpDouble(0.7, 0, value)!;
          return Positioned(
              bottom: bottom,
              right: right,
              child: Icon(
                Icons.face,
                color: Colors.green.withOpacity(opacity),
                size: (size.width * 0.05 + randomSize).toDouble(),
              ));
        });
  }
}
