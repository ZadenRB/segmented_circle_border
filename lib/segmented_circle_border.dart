library segmented_circle_border;

import 'dart:math';
import 'package:flutter/painting.dart';

/// A border that fits a segmented circle within the available space.
class SegmentedCircleBorder extends ShapeBorder {
  /// Creates a segmented circle border.
  ///
  /// Length of [sides] must be less than [numberOfSegments].
  SegmentedCircleBorder({this.offset = 0.0, this.numberOfSegments, this.sides}) {
    for (int i = sides.length; i < numberOfSegments; i++) {
      sides.add(BorderSide.none);
    }
    assert(sides != null);
    assert(sides.length <= numberOfSegments);
  }

  /// The angle to offset each segment by. An offset of zero
  /// radians meaning the first segment begins at the
  /// point on the right hand side of the oval that
  /// crosses the horizontal line that intersects the center of the
  /// rectangle and with positive angles going clockwise around the
  /// oval.
  final double offset;

  /// The number of segments the circle has. If fewer
  /// sides are provided than the [numberOfSegments],
  /// the remaining segments will be empty.
  final int numberOfSegments;

  /// The segments of the circle.
  final List<BorderSide> sides;

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.all(sides.map((e) => e.width).reduce(max));

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => Path()
    ..addOval(Rect.fromCircle(
        center: rect.center,
        radius: max(0.0,
            rect.shortestSide / 2.0 - sides.map((e) => e.width).reduce(max))));

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    double widestSide = sides.map((e) => e.width).reduce(max);
    double innerRadius = rect.shortestSide / 2.0 - widestSide;
    Path ret = Path();
    double radiansPerSegment = 2 * pi / numberOfSegments;
    for (int i = 0; i < sides.length; i++) {
      ret.arcTo(
          Rect.fromCircle(
              center: rect.center, radius: innerRadius + sides[i].width),
          i * radiansPerSegment + offset,
          radiansPerSegment,
          false);
      ret.lineTo(
          rect.center.dx +
              cos((i + 1) * radiansPerSegment + offset) *
                  (innerRadius + sides[(i + 1) % sides.length].width),
          rect.center.dy +
              sin((i + 1) * radiansPerSegment + offset) *
                  (innerRadius + sides[(i + 1) % sides.length].width));
    }
    return ret;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    double widestSide = sides.map((e) => e.width).reduce(max);
    double innerRadius = (rect.shortestSide - widestSide) / 2.0;
    double radiansPerSegment = 2 * pi / numberOfSegments;
    for (int i = 0; i < sides.length; i++) {
      canvas.drawArc(
        Rect.fromCircle(
            center: rect.center,
            radius: innerRadius - ((widestSide - sides[i].width) / 2.0)),
        i * radiansPerSegment + offset,
        radiansPerSegment,
        false,
        sides[i].toPaint(),
      );
    }
  }

  @override
  ShapeBorder scale(double t) => SegmentedCircleBorder(
        offset: offset,
        numberOfSegments: numberOfSegments,
        sides: sides.map((e) => e.scale(t)),
      );

  @override
  String toString() {
    return '$runtimeType($offset, $numberOfSegments, $sides)';
  }
}
