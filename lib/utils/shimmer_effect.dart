import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
    this.border,
    this.shape = BoxShape.rectangle,
    this.child,
  });

  final double width;
  final double height;
  final double radius;
  final Color? color;
  final BoxBorder? border;
  final BoxShape shape;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child:
          child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color ?? (Colors.white),
              shape: shape,
              border: border,
              borderRadius: shape == BoxShape.rectangle
                  ? BorderRadius.circular(radius)
                  : null,
            ),
          ),
    );
  }
}
