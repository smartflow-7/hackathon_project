import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/Widgets/Time_buttons.dart';
import 'package:hackathon_project/Widgets/apptheme.dart';
import 'package:hackathon_project/models/Chartdata.dart';
import 'package:hackathon_project/models/Providers/chartdataprovider.dart';
import 'package:provider/provider.dart';
import 'package:redacted/redacted.dart';

class Stocklinechart extends StatefulWidget {
  const Stocklinechart({
    super.key,
    required this.themecolor,
  });
  final ColorScheme themecolor;

  @override
  State<Stocklinechart> createState() => _StocklinechartState();
}

class _StocklinechartState extends State<Stocklinechart> {
  String currentIndex = '6M';
  @override
  Widget build(BuildContext context) {
    return Consumer<Chartdataprovider>(builder: (context, chart, child) {
      // Debug logging to track data flow
      debugPrint(
          'Chart state - Loading: ${chart.isLoading}, Error: ${chart.hasError}, Data: ${chart.stockDataList.length} items');

      // Loading state
      if (chart.isLoading && chart.stockDataList.isEmpty) {
        return _buildLoadingState();
      }

      // Error state
      if (chart.hasError) {
        chart.refresh;
        return _buildErrorState(chart.errorMessage);
      }

      // Empty data state
      if (chart.stockDataList.isEmpty) {
        return _buildEmptyState();
      }

      try {
        // Filter and validate data
        List<chartdata> filteredData = _getFilteredData(chart.stockDataList);
        List<FlSpot> spots = _convertToFlSpots(filteredData);

        debugPrint(
            'Filtered data: ${filteredData.length} items, ${spots.length} valid spots');

        // Handle cases with limited data points
        if (spots.isEmpty) {
          // Create placeholder data if no valid points exist
          spots = [const FlSpot(0, 0), const FlSpot(1, 0)];
          return _buildChart(filteredData, spots, isPlaceholder: true);
        } else if (spots.length == 1) {
          // Duplicate single point to create a line
          spots.add(FlSpot(spots[0].x + 1, spots[0].y));
          return _buildChart(filteredData, spots);
        }

        return _buildChart(filteredData, spots);
      } catch (e) {
        debugPrint('Chart rendering error: $e');
        return _buildErrorState('Failed to render chart');
      }
    });
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          Container(
            height: 160,
            color: widget.themecolor.onPrimary,
          ).redacted(context: context, redact: true),
          const SizedBox(height: 20),
          _buildTimeRow(),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'Error: $errorMessage',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildTimeRow(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          const SizedBox(
            height: 200,
            child: Center(
              child: Text('No data available'),
            ),
          ),
          const SizedBox(height: 20),
          _buildTimeRow(),
        ],
      ),
    );
  }

  Widget _buildTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildTimeButtons(currentIndex),
    );
  }

  Widget _buildChart(List<chartdata> filteredData, List<FlSpot> spots,
      {bool isPlaceholder = false}) {
    // Calculate chart parameters with safe defaults
    final minX = spots.first.x;
    final maxX = spots.last.x;
    final minY = isPlaceholder ? 100 : max(0, _getMinY(spots));
    final maxY = isPlaceholder ? 100 : _getMaxY(spots) * 1.05;

    return Column(
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LineChart(
            LineChartData(
              minX: minX,
              maxX: maxX,
              minY: minY.toDouble(),
              maxY: maxY.toDouble(),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  color: isPlaceholder
                      ? Colors.grey.withOpacity(0.5)
                      : Apptheme.primary,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        (isPlaceholder
                            ? Colors.grey.withOpacity(0.1)
                            : const Color.fromARGB(42, 4, 38, 208)),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    interval: _getYInterval(spots),
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '\$${value.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 10,
                          color: widget.themecolor.onSurface.withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: _getXInterval(spots.length),
                    getTitlesWidget: (value, meta) {
                      return _getBottomTitle(value.toInt(), filteredData);
                    },
                  ),
                ),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: _getYInterval(spots),
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: widget.themecolor.onSurface.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                enabled: !isPlaceholder,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      if (spot.spotIndex < filteredData.length) {
                        final data = filteredData[spot.spotIndex];
                        return LineTooltipItem(
                          '${data.symbol}\n'
                          '\$${data.price?.toStringAsFixed(2) ?? 'N/A'}\n'
                          '${_formatDate(data.date)}',
                          TextStyle(
                            color: widget.themecolor.onSurface,
                            fontSize: 12,
                          ),
                        );
                      }
                      return null;
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildTimeRow(),
      ],
    );
  }

  List<Widget> _buildTimeButtons(String currentIndex) {
    return ['1D', '1W', '1M', '6M', '1Y'].map((range) {
      return TimeButtons(
        index: currentIndex,
        buttonindex: range,
        onTap: () => _onTimeButtonTap(range),
      );
    }).toList();
  }

  void _onTimeButtonTap(String timeRange) {
    setState(() {
      currentIndex = timeRange;
    });
  }

  List<chartdata> _getFilteredData(List<chartdata> allData) {
    if (allData.isEmpty) return [];

    // First filter out invalid data
    final validData = allData.where((data) {
      if (data.date == null || data.price == null || data.price! <= 0) {
        return false;
      }
      try {
        DateTime.parse(data.date!);
        return true;
      } catch (e) {
        return false;
      }
    }).toList();

    if (validData.isEmpty) return [];

    DateTime now = DateTime.now();
    DateTime cutoffDate;

    switch (currentIndex) {
      case '1D':
        cutoffDate = now.subtract(const Duration(days: 1));
        break;
      case '1W':
        cutoffDate = now.subtract(const Duration(days: 7));
        break;
      case '1M':
        cutoffDate = now.subtract(const Duration(days: 30));
        break;
      case '6M':
        cutoffDate = now.subtract(const Duration(days: 180));
        break;
      case '1Y':
        cutoffDate = now.subtract(const Duration(days: 365));
        break;
      default:
        cutoffDate = now.subtract(const Duration(days: 30));
    }

    List<chartdata> filtered = validData.where((data) {
      try {
        return DateTime.parse(data.date!).isAfter(cutoffDate);
      } catch (e) {
        return false;
      }
    }).toList();

    // Sort by date (oldest first)
    filtered.sort((a, b) {
      try {
        return DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!));
      } catch (e) {
        return 0;
      }
    });

    return filtered.isNotEmpty ? filtered : validData.take(60).toList();
  }

  List<FlSpot> _convertToFlSpots(List<chartdata> data) {
    return data
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final item = entry.value;
          return FlSpot(index.toDouble(), item.price ?? 0);
        })
        .where((spot) => spot.y > 0)
        .toList();
  }

  double _getMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    double min = spots.first.y;
    for (final spot in spots) {
      if (spot.y < min) {
        min = spot.y;
      }
    }
    return min * 0.95; // 5% padding below
  }

  double _getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 100;
    double max = spots.first.y;
    for (final spot in spots) {
      if (spot.y > max) {
        max = spot.y;
      }
    }
    return max * 1.05; // 5% padding above
  }

  double _getYInterval(List<FlSpot> spots) {
    if (spots.isEmpty) return 10;
    final range = _getMaxY(spots) - _getMinY(spots);
    return range / 4;
  }

  double _getXInterval(int dataLength) {
    if (dataLength <= 5) return 1;
    return (dataLength / 5).floorToDouble();
  }

  Widget _getBottomTitle(int index, List<chartdata> data) {
    if (index >= data.length || data[index].date == null) {
      return const Text('');
    }

    try {
      final date = DateTime.parse(data[index].date!);
      switch (currentIndex) {
        case '1D':
          return Text(
            '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 10,
              color: widget.themecolor.onSurface.withOpacity(0.7),
            ),
          );
        case '1W':
        case '1M':
        case '6M':
          return Text(
            '${date.month}/${date.day}',
            style: TextStyle(
              fontSize: 10,
              color: widget.themecolor.onSurface.withOpacity(0.7),
            ),
          );
        case '1Y':
          return Text(
            '${date.month}/${date.year.toString().substring(2)}',
            style: TextStyle(
              fontSize: 10,
              color: widget.themecolor.onSurface.withOpacity(0.7),
            ),
          );
        default:
          return Text(
            '${date.month}/${date.day}',
            style: TextStyle(
              fontSize: 10,
              color: widget.themecolor.onSurface.withOpacity(0.7),
            ),
          );
      }
    } catch (e) {
      return const Text('');
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.month}/${date.day}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
