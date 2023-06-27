import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class PricePoint {
  final double x;
  final double y;
  PricePoint(this.x, this.y);
}

List<PricePoint> get pricePoints {
  final data = {
    1: 300000.0,
    2: 100000.0,
    4: 5000.0,
    10: 150000.0,
    15: 100000.0,
    20: 2000.0,
    30: 800000.0
  };

  return data.entries
      .map((entry) => PricePoint(entry.key.toDouble(), entry.value))
      .toList();
}

class LineTitles {
  static getLineTitles() => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 25)),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 50)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)));
}
