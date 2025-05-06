import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  final double width;
  final double height;

  const DefaultLoading({super.key, this.width = 40, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: CircularProgressIndicator(strokeWidth: 1));
  }
}
