import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CollapseCard extends StatefulWidget {
  const CollapseCard({super.key, required this.title, required this.body});

  final Widget title;
  final Widget body;

  @override
  State<CollapseCard> createState() => _CollapseCardState();
}

class _CollapseCardState extends State<CollapseCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _expanded = false;
  set expanded(bool value) {
    _expanded = value;
    if(value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(
        milliseconds: 200,
      ),
    )..addListener(
        () => setState(() {}),
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: widget.title),
                Transform.rotate(
                  angle: (_animationController.value - 1) * pi,
                  child: IconButton(
                    onPressed: () {
                      expanded = !_expanded;
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                    ),
                  ),
                ),
              ],
            ),
            Gap(16 * _animationController.value),
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: _animationController.value,
                child: widget.body,
              ),
            )
          ],
        ),
      ),
    );
  }
}
