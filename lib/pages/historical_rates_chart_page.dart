import 'package:currency_exchange_app/models/currency_model.dart';
import 'package:currency_exchange_app/network/api_service.dart';
import 'package:currency_exchange_app/utils/colors.dart';
import 'package:currency_exchange_app/utils/custom_progress_indicator.dart';
import 'package:currency_exchange_app/utils/dimens.dart';
import 'package:currency_exchange_app/utils/string.dart';
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
      setState(() {
        _errorMessage = null;
        _isLoading = true;
      });
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

  Widget buildCurrencyChart(
      {required String baseCurrency, required String currency}) {
    List<FlSpot> spots = _getYearlySpots(currency);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$baseCurrency to $currency exchange rate per year',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        spots.isEmpty
            ? Center(
                child: Text(kDataNotFoundText),
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
                          axisNameWidget: const Text(kRateText,
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
                          axisNameWidget: const Text(kYearText,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
            child: _isLoading
                ? Center(child: CustomProgressIndicator())
                : _errorMessage != null
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$_errorMessage',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .inverseSurface),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _fetchData();
                                  });
                                },
                                child: Text(kRetryButtonText,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer)),
                              )
                            ],
                          ),
                        ),
                      )
                    : SafeArea(
                        child: DefaultTabController(
                          initialIndex: 1,
                          length: Code.values.length,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              title: Text(kHistoricalRatePageTitle),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: kTitleFontSize,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
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
                                return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: buildCurrencyChart(
                                        baseCurrency: 'USD',
                                        currency: code.value));
                              }).toList(),
                            ),
                          ),
                        ),
                      )));
  }
}
