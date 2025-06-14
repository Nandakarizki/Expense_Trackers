import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarData());
  }

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 75,
            getTitlesWidget: leftTitles,
            interval: 1, // Show titles at every integer
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      barGroups: showingGroups(),
      maxY: 5, // Set max Y to 5 to match your highest label
    );
  }

  Widget getTitles(double val, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (val.toInt()) {
      case 0:
        text = const Text("01", style: style);
        break;
      case 1:
        text = const Text("02", style: style);
        break;
      case 2:
        text = const Text("03", style: style);
        break;
      case 3:
        text = const Text("04", style: style);
        break;
      case 4:
        text = const Text("05", style: style);
        break;
      case 5:
        text = const Text("06", style: style);
        break;
      case 6:
        text = const Text("07", style: style);
        break;
      case 7:
        text = const Text("08", style: style);
        break;
      default:
        text = const Text("", style: style);
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 16, child: text);
  }

  Widget leftTitles(double val, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;

    switch (val.toInt()) {
      case 0:
        text = "0";
        break;
      case 1:
        text = "Rp 200K";
        break;
      case 2:
        text = "Rp 300K";
        break;
      case 3:
        text = "Rp 400K";
        break;
      case 4:
        text = "Rp 500K";
        break;
      case 5:
        text = "Rp 600K";
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            transform: const GradientRotation(3.14 / 40),
          ),
          width: 15,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, 2);
      case 1:
        return makeGroupData(1, 3);
      case 2:
        return makeGroupData(2, 2);
      case 3:
        return makeGroupData(3, 4.5);
      case 4:
        return makeGroupData(4, 3.8);
      case 5:
        return makeGroupData(5, 1.5);
      case 6:
        return makeGroupData(6, 4);
      default:
        return throw Error();
    }
  });
}
