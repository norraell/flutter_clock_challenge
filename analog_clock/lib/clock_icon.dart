import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// icon inside the clock visualising the current weather condition
class ClockIcon extends StatelessWidget {
  ClockIcon({
    @required this.condition,
    @required this.color,
  })  : assert(condition != null),
        assert(color != null);

  final String condition;
  final Color color;
  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (condition) {
      case 'cloudy':
        icon = Icons.wb_cloudy;
        break;
      case 'foggy':
        icon = Icons.blur_on;
        break;
      case 'rainy':
        icon = Icons.local_car_wash;
        break;
      case 'snowy':
        icon = Icons.ac_unit;
        break;
      case 'thunderstorm':
        icon = Icons.flash_on;
        break;
      case 'windy':
        icon = Icons.toys;
        break;
      case 'sunny':
      default:
        icon = Icons.wb_sunny;
    }

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Clock icon representing condition $condition',
        value: condition,
      ),
      child: Container(
        alignment: Alignment.centerRight,
        child: Icon(icon, color: color),
      ),
    );
  }
}
