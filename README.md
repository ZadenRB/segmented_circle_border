# segmented_circle_border

![](https://raw.githubusercontent.com/ZadenRB/segmented_circle_border/master/Segmented%20Circle%20Border.png)

A package for creating segmented circle borders in flutter.

## Getting Started

Add the package to your `pubspec.yaml`:

`segmented_circle_border: ^2.0.0` 

Add it as a border:

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:segmented_circle_border/segmented_circle_border.dart';

void main() => runApp(SegmentedCircleBorderExample());

class SegmentedCircleBorderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
      shape: SegmentedCircleBorder(
          offset: -(112.5 * pi / 180),
          numberOfSegments: 8,
          sides: <BorderSide>[
            BorderSide(color: Color(0xFFFF0000), width: 10.0),
            BorderSide(color: Color(0xFF00FF00), width: 1.0),
            BorderSide(color: Color(0xFF0000FF), width: 2.0),
            BorderSide(color: Color(0xFFFF0000), width: 3.0),
            BorderSide(color: Color(0xFF00FF00), width: 4.0),
            BorderSide(color: Color(0xFF0000FF), width: 5.0),
            BorderSide(color: Color(0xFFFF00000), width: 6.0),
            BorderSide(color: Color(0xFF00FF00), width: 7.0),
          ]),
      child: Container(
        width: 100,
        height: 100,
      ));
}
```
