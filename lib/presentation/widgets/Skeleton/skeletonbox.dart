import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonBox({
    super.key,
    required this.height,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}



extension SkeletonShimmer on Widget {
  Widget shimmer() {
    return animate(
      onPlay: (c) => c.repeat(),
    ).shimmer(
      duration: 1200.ms,
      color: Colors.white.withOpacity(0.2),
    );
  }
}
