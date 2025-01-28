import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/network/api_service.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/custom_progress_indicator.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoricalRatesChart extends StatefulWidget {
  const HistoricalRatesChart({super.key});

  @override
  State<HistoricalRatesChart> createState() => _HistoricalRatesChartState();
}

class _HistoricalRatesChartState extends State<HistoricalRatesChart> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _rates;
  List<String> currencies = Code.values.map((code) {
    return code.value;
  }).toList();
  String selectedCurrency = 'PHP';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Map<String, dynamic> data = await _apiService.fetchExchangeRates(
          startDate: '2024-01-01', endDate: '2025-01-26', baseCurrency: 'USD');

      setState(() {
        _rates = data['rates'];
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  List<FlSpot> _getYearlySpots(String currency) {
    Map<int, double> yearlyRates = {};

    _rates?.forEach((date, rateData) {
      DateTime dateTime = DateTime.parse(date);
      int year = dateTime.year;
      if (rateData.containsKey(currency)) {
        double rate = (rateData[currency] as num).toDouble();
        yearlyRates[year] = rate;
      }
    });
    List<FlSpot> spots = [];
    yearlyRates.forEach((year, rate) {
      spots.add(FlSpot(year.toDouble(), rate));
    });

    return spots;
  }

  Widget buildCurrencyChart(String currency) {
    List<FlSpot> spots = _getYearlySpots(currency);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$currency Exchange Rate per Year',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          spots.isEmpty
              ? Center(
                  child: Text("Data not found"),
                )
              : AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        clipData: FlClipData.all(),
                        borderData: FlBorderData(show: true),
                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              interval: 1,
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                            axisNameWidget: const Text('Rate',
                                style: TextStyle(fontSize: 14)),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                            axisNameWidget: const Text('Year',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            preventCurveOverShooting: true,
                            isCurved: true,
                            isStrokeJoinRound: true,
                            spots: spots,
                            isStrokeCapRound: true,
                            barWidth: 3,
                            color: kPrimaryColor,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: true),
                          ),
                        ],
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: true,
                          horizontalInterval: 1,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        // Tooltip data
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              getTooltipItems:
                                  (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((touchedBarSpot) {
                                  return LineTooltipItem(
                                    'Year: ${touchedBarSpot.x.toInt()} - Rate: ${touchedBarSpot.y.toStringAsFixed(2)}',
                                    const TextStyle(),
                                  );
                                }).toList();
                              }),
                          handleBuiltInTouches: true,
                        ),
                      ),
                    ),
                  ),
                ),
          Spacer()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [kCardGradient1, kCardGradient2, kCardGradient3],
                  radius: 3,
                  center: Alignment(-2, -1)),
            ),
            child: _isLoading
                ? Center(child: CustomProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text('Error: $_errorMessage'))
                    :
                    // Container(
                    //     color: Colors.transparent,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: ListView(
                    //         children: [
                    //           buildCurrencyChart('PHP', Colors.blue),
                    //           buildCurrencyChart('THB', Colors.green),
                    //           buildCurrencyChart('SGD', Colors.red),
                    //         ],
                    //       ),
                    //     ),
                    //   ),

                    // DefaultTabController(
                    //     initialIndex: 0,
                    //     length: Code.values.length,
                    //     child: Column(
                    //       children: [
                    //         TabBar(tabs: [
                    //           Tab(
                    //             icon: Flag.fromString('US'),
                    //           ),
                    //           Tab(
                    //             icon: Flag.fromString('US'),
                    //           ),
                    //           Tab(
                    //             icon: Flag.fromString('US'),
                    //           )
                    //         ]),
                    //         TabBarView(
                    //           children: [
                    //             buildCurrencyChart('PHP', Colors.blue),
                    //             buildCurrencyChart('THB', Colors.green),
                    //             buildCurrencyChart('SGD', Colors.red),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: DefaultTabController(
                          initialIndex: 1,
                          length: Code.values.length,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              title: Text('Exchange Rate Chart per Year'),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                              bottom: TabBar(
                                tabAlignment: TabAlignment.start,
                                isScrollable: true,
                                tabs: Code.values.map((code) {
                                  return Tab(
                                    text: code.value,
                                  );
                                }).toList(),
                              ),
                            ),
                            body: TabBarView(
                              children: Code.values.map((code) {
                                return buildCurrencyChart(code.value);
                              }).toList(),
                            ),
                          ),
                        ),
                      )));
  }
}
