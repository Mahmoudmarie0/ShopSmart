import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key, this.iconSize = 20, this.color = Colors.transparent});
  final double iconSize;
  final Color? color;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            IconlyLight.heart,
            size: widget.iconSize,
          ),
          style: IconButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
          ),
        ));
  }
}
