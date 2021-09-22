import 'package:flutter/material.dart';
import 'package:yc_test/common/app_utilities/app_theme.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';
import 'dart:math' as math;

import 'emojiflow.dart';

class LiveTest extends StatefulWidget {
  @override
  _LiveTestState createState() => _LiveTestState();
}

class _LiveTestState extends State<LiveTest>
    with SingleTickerProviderStateMixin {
  // late Animation<double> animation;
  late AnimationController animationController;
  late Size size;
  final int randomSize = math.Random().nextInt(18);
  List<Widget> _emojis = <Widget>[];

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: DxTextBlack("animation"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: materialPrimaryColor,
                          child: TextButton(
                              onPressed: () {
                                animationController.forward();
                              },
                              child: DxTextWhite("Old "
                                  "Animation")),
                        ),
                        Container(
                          color: materialPrimaryColor,
                          child: TextButton(
                              onPressed: () {
                                addEmoji();
                              },
                              child: DxTextWhite("New Animation")),
                        ),
                      ],
                    ),
                  )),
              Positioned(child: animatebody()),
              Positioned(child: floating()),
            ],
          ),
        ),
      ),
    );
  }

  Widget animatebody() {
    return Stack(children: [
      Positioned(
        bottom: 30,
        left: 1,
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            curve: Curves.fastOutSlowIn,
            parent: animationController,
          )),
          child: SlideTransition(
            position:
                Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -5.0))
                    .animate(CurvedAnimation(
              curve: Curves.fastOutSlowIn,
              parent: animationController,
            )),
            child: Container(
              width: 100,
              height: 100,
              child: Icon(Icons.face, color: Colors.green, size: 35),
            ),
          ),
        ),
      ),
    ]);
  }

  void addEmoji() {
    setState(() {
      _emojis.add(EmojiAnimation());
    });
  }

  Widget floating() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Stack(children: _emojis),
    );
  }
}
