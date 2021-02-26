import 'package:flutter/material.dart';

import '../Colors.dart';

class DataRepository {
  static List<double> data = [];
  static List<double> _data = [100, 190, 270, 50];

  static List<double> getData() {
    data = _data;
    return _data;
  }

  static void clearData() {
    data = [];
  }

  static List<String> getLabels() {
    List<String> labels = [
      'SESIÓN 1',
      'SESIÓN 2',
      'SESIÓN 3',
      'SESIÓN 4',
    ];

    return labels;
  }

  static Color getColor(double value) {
    if (value < 100) {
      return red;
    } else if (value < 150) {
      return cyan;
    } else
      return green;
  }

  static Color getDayColor(int day) {
    if (day < data.length) {
      return getColor(data[day]);
    } else
      return Colors.indigo.shade50;
  }

  static Icon getIcon(double value) {
    if (value < 100) {
      return Icon(
        Icons.sentiment_neutral_rounded,
        size: 24,
        color: getColor(value),
      );
    } else if (value < 150) {
      return Icon(
        Icons.sentiment_satisfied_alt_rounded,
        size: 24,
        color: getColor(value),
      );
    } else
      return Icon(
        Icons.sentiment_very_satisfied_rounded,
        size: 24,
        color: getColor(value),
      );
  }
}
