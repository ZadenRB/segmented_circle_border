library segmented_circle_border;

import 'dart:math';
import 'package:flutter/painting.dart';

/// A border that fits a segmented circle within the available space.
class SegmentedCircleBorder extends ShapeBorder {
  SegmentedCircleBorder(
      {this.top = BorderSide.none,
      this.topRight = BorderSide.none,
      this.right = BorderSide.none,
      this.bottomRight = BorderSide.none,
      this.bottom = BorderSide.none,
      this.bottomLeft = BorderSide.none,
      this.left = BorderSide.none,
      this.topLeft = BorderSide.none,
      this.offset = 0.0})
      : assert(top != null),
        assert(topRight != null),
        assert(right != null),
        assert(bottomRight != null),
        assert(bottom != null),
        assert(bottomLeft != null),
        assert(left != null),
        assert(topLeft != null),
        assert(offset != null);

  final double offset;
  final BorderSide top,
      topRight,
      right,
      bottomRight,
      bottom,
      bottomLeft,
      left,
      topLeft;

  double radians(double degrees) => degrees * pi / 180;

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.fromLTRB(left.width, top.width, right.width, bottom.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => Path()
    ..addOval(Rect.fromCircle(
        center: rect.center,
        radius: max(
            0.0,
            rect.shortestSide / 2.0 -
                [
                  top.width,
                  topRight.width,
                  right.width,
                  bottomRight.width,
                  bottom.width,
                  bottomLeft.width,
                  left.width,
                  topLeft.width
                ].reduce(max))));

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    double widestSide = [
      top.width,
      topRight.width,
      right.width,
      bottomRight.width,
      bottom.width,
      bottomLeft.width,
      left.width,
      topLeft.width
    ].reduce(max);
    double innerRadius = rect.shortestSide / 2.0 - widestSide;
    return Path()
      ..arcTo(
          Rect.fromCircle(center: rect.center, radius: innerRadius + top.width),
          radians(247.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(292.5 + offset)) * (innerRadius + topRight.width),
          rect.center.dy +
              sin(radians(292.5 + offset)) * (innerRadius + topRight.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + topRight.width),
          radians(292.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(337.5 + offset)) * (innerRadius + right.width),
          rect.center.dy +
              sin(radians(337.5 + offset)) * (innerRadius + right.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + right.width),
          radians(337.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(22.5 + offset)) * (innerRadius + bottomRight.width),
          rect.center.dy +
              sin(radians(22.5 + offset)) * (innerRadius + bottomRight.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + bottomRight.width),
          radians(22.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(67.5 + offset)) * (innerRadius + bottom.width),
          rect.center.dy +
              sin(radians(67.5 + offset)) * (innerRadius + bottom.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + bottom.width),
          radians(67.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(112.5 + offset)) * (innerRadius + bottomLeft.width),
          rect.center.dy +
              sin(radians(112.5 + offset)) * (innerRadius + bottomLeft.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + bottomLeft.width),
          radians(112.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(157.5 + offset)) * (innerRadius + left.width),
          rect.center.dy +
              sin(radians(157.5 + offset)) * (innerRadius + left.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + left.width),
          radians(157.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(202.5 + offset)) * (innerRadius + topLeft.width),
          rect.center.dy +
              sin(radians(202.5 + offset)) * (innerRadius + topLeft.width))
      ..arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + topLeft.width),
          radians(202.5 + offset),
          radians(45),
          false)
      ..lineTo(
          rect.center.dx +
              cos(radians(247.5 + offset)) * (innerRadius + top.width),
          rect.center.dy +
              sin(radians(247.5 + offset)) * (innerRadius + top.width));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    double widestSide = [
      top.width,
      topRight.width,
      right.width,
      bottomRight.width,
      bottom.width,
      bottomLeft.width,
      left.width,
      topLeft.width
    ].reduce(max);
    double innerRadius = (rect.shortestSide - widestSide) / 2.0;
    canvas
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - top.width) / 2.0)),
          radians(247.5 + offset),
          radians(45),
          false,
          top.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - topRight.width) / 2.0)),
          radians(292.5 + offset),
          radians(45),
          false,
          topRight.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - right.width) / 2.0)),
          radians(337.5 + offset),
          radians(45),
          false,
          right.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - bottomRight.width) / 2.0)),
          radians(22.5 + offset),
          radians(45),
          false,
          bottomRight.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - bottom.width) / 2.0)),
          radians(67.5 + offset),
          radians(45),
          false,
          bottom.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - bottomLeft.width) / 2.0)),
          radians(112.5 + offset),
          radians(45),
          false,
          bottomLeft.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - left.width) / 2.0)),
          radians(157.5 + offset),
          radians(45),
          false,
          left.toPaint())
      ..drawArc(
          Rect.fromCircle(
              center: rect.center,
              radius: innerRadius - ((widestSide - topLeft.width) / 2.0)),
          radians(202.5 + offset),
          radians(45),
          false,
          topLeft.toPaint());
  }

  @override
  ShapeBorder scale(double t) => SegmentedCircleBorder(
      top: top.scale(t),
      topRight: topRight.scale(t),
      right: right.scale(t),
      bottomRight: bottomRight.scale(t),
      bottom: bottom.scale(t),
      bottomLeft: bottomLeft.scale(t),
      left: left.scale(t),
      topLeft: topLeft.scale(t));

  @override
  String toString() {
    return '$runtimeType($top, $topRight, $right, $bottomRight, $bottom, $bottomLeft, $left, $topLeft)';
  }
}
