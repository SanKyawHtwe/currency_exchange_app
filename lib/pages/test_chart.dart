import 'package:currency_exchange_app/network/api_service.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TestChart extends StatefulWidget {
  const TestChart({super.key});

  @override
  State<TestChart> createState() => _TestChartState();
}

class _TestChartState extends State<TestChart> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _rates;
  List<String> currencies = ['PHP', 'THB', 'SGD'];
  String selectedCurrency = 'PHP';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Map<String, dynamic> data = await _apiService.fetchExchangeRates(
        startDate: '2024-01-01',
        endDate: '2025-01-26',
      );

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

  Widget buildCurrencyChart(String currency, Color lineColor) {
    List<FlSpot> spots = _getYearlySpots(currency);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$currency Exchange Rate per Year',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                clipData: FlClipData.all(),
                borderData: FlBorderData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 70,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black),
                        );
                      },
                    ),
                    axisNameWidget:
                        const Text('Rate', style: TextStyle(fontSize: 14)),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        );
                      },
                    ),
                    axisNameWidget:
                        const Text('Year', style: TextStyle(fontSize: 14)),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    isStrokeJoinRound: true,
                    spots: spots,
                    isStrokeCapRound: true,
                    barWidth: 3,
                    color: lineColor,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: true),
                  ),
                ],
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 0.5,
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
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((touchedBarSpot) {
                      return LineTooltipItem(
                        'Year: ${touchedBarSpot.x.toInt()} - Rate: ${touchedBarSpot.y.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  }),
                  handleBuiltInTouches: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Exchange Rate Chart per Year'),
        ),
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
                  : Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children: [
                            buildCurrencyChart('PHP', Colors.blue),
                            buildCurrencyChart('THB', Colors.green),
                            buildCurrencyChart('SGD', Colors.red),
                          ],
                        ),
                      ),
                    ),
        ));
  }
}
