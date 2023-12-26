import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF34D287),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Aprovados',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF55150),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Reprovado',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFEBB3B),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Segunda Época',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      const radius = 30.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF34D287),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.bodyMedium,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFF55150),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.bodyMedium,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFFEBB3B),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: Theme.of(context).textTheme.bodyMedium,
          );
        default:
          throw Error();
      }
    });
  }
}
