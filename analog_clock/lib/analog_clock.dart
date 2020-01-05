// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/clock_bells.dart';
import 'package:analog_clock/clock_legs.dart';
import 'package:analog_clock/clock_colors.dart';
import 'package:analog_clock/clock_frame.dart';
import 'package:analog_clock/clock_icon.dart';
import 'package:analog_clock/minute_pin.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
class AlarmClock extends StatefulWidget {
  const AlarmClock(this.model);

  final ClockModel model;

  @override
  _AlarmClockState createState() => _AlarmClockState();
}

class _AlarmClockState extends State<AlarmClock> {
  var _now = DateTime.now();
  var _temperature = '12';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AlarmClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final clockTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: ClockColors.coolGrey.shade800,
            disabledColor: ClockColors.coolGrey.shade800,
            // Minute hand.
            highlightColor: ClockColors.blue.shade700,
            dividerColor: ClockColors.coolGrey.shade900,
            canvasColor: ClockColors.coolGrey.shade50,
            backgroundColor: ClockColors.coolGrey.shade200,
          )
        : Theme.of(context).copyWith(
            primaryColor: ClockColors.coolGrey.shade200,
            disabledColor: ClockColors.coolGrey.shade100,
            highlightColor: ClockColors.coolGrey.shade100,
            dividerColor: ClockColors.coolGrey.shade400,
            canvasColor: ClockColors.coolGrey.shade900,
            backgroundColor: ClockColors.coolGrey.shade700,
          );

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: clockTheme.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClockIcon(
            condition: _condition,
            color: clockTheme.primaryColor,
          ),
          Row(
            children: <Widget>[
              Text(
                _temperature.substring(0, _temperature.length - 2),
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 0, 24),
                child: Text(
                  _temperature.substring(_temperature.length - 1),
                ),
              ),
            ],
          ),
          Text(_location.split(',')[0]),
        ],
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: clockTheme.backgroundColor,
        child: Stack(
          children: [
            /// legs of alarm clock
            ClockLegs(
              color: clockTheme.disabledColor,
            ),

            /// bells of alarm clock
            ClockBells(
              color: clockTheme.disabledColor,
            ),

            /// background of clock face
            Clockframe(
              color: clockTheme.canvasColor,
            ),

            /// minute lines on clock face
            MinutePin(
              color: clockTheme.dividerColor,
              thickness: 2,
            ),

            /// hour hand
            DrawnHand(
              color: clockTheme.highlightColor,
              kind: HandKind.hour,
              thickness: 8,
              size: 1,
              angleRadians: (_now.hour + _now.minute / 60) * radiansPerHour,
            ),

            /// minute hand
            DrawnHand(
              color: clockTheme.highlightColor,
              kind: HandKind.minute,
              thickness: 4,
              size: 1,
              angleRadians: _now.minute * radiansPerTick,
            ),

            /// second hand [CustomPainter].
            DrawnHand(
              color: clockTheme.primaryColor,
              kind: HandKind.second,
              thickness: 1,
              size: 1,
              angleRadians: _now.second * radiansPerTick,
            ),

            /// Clock center piece with further weather information
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 120.00,
                  height: 120.00,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: weatherInfo,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
