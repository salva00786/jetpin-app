import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Assicurati di avere questo package
import 'package:intl/intl.dart';      // Per DateFormat
import '../services/stats_service.dart';
import '../utils/premium_manager.dart';
import '../models/review.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ReviewStatsPage extends StatefulWidget {
  const ReviewStatsPage({super.key});

  @override
  State<ReviewStatsPage> createState() => _ReviewStatsPageState();
}

class _ReviewStatsPageState extends State<ReviewStatsPage> {
  List<Review> _reviews = [];
  bool _isLoading = true;
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final bool premiumStatus = await PremiumManager.isPremium();
    if (!mounted) return;

    if (!premiumStatus) {
      setState(() {
        _isLoading = false;
        _isPremium = false;
      });
      return;
    }

    final List<Review> userReviews = await StatsService.getUserReviews();
    if (mounted) {
      setState(() {
        _reviews = userReviews;
        _isPremium = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isPremium) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.reviewStatsPageAppBarTitle),
        ),
        body: Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            localizations.featureOnlyForPremiumUsers,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )),
      );
    }

    if (_reviews.isEmpty && _isPremium) { // Non dovrebbe accadere se _loadData popola _reviews
       return Scaffold(
        appBar: AppBar(
          title: Text(localizations.reviewStatsPageAppBarTitle),
        ),
        body: Center(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            localizations.reviewStatsNoReviewsYet, 
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )),
      );
    }

    final String avgRating = StatsService.getAverageRating(_reviews).toStringAsFixed(1);
    final Map<String, int> reviewsByAirline = StatsService.getReviewsByAirline(_reviews);
    final Map<String, int> reviewsByMonth = StatsService.getReviewsByMonth(_reviews);
    final List<MapEntry<String, int>> sortedReviewsByMonth = reviewsByMonth.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      appBar: AppBar(title: Text(localizations.reviewStatsPageAppBarTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.reviewStatsAverageRatingLabelFull(avgRating),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),
            Text(
              localizations.reviewStatsByAirlineLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            if (reviewsByAirline.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(localizations.reviewStatsNoAirlineData, style: const TextStyle(fontStyle: FontStyle.italic)),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewsByAirline.length,
                itemBuilder: (context, index) {
                  final entry = reviewsByAirline.entries.elementAt(index);
                  return ListTile(
                    leading: const Icon(Icons.flight_takeoff_outlined),
                    title: Text(entry.key),
                    trailing: Text('${entry.value} ${entry.value == 1 ? localizations.reviewStatsReviewSingular : localizations.reviewStatsReviewPlural}'),
                    contentPadding: EdgeInsets.zero,
                  );
                },
              ),
            const SizedBox(height: 24.0),
            Text(
              localizations.reviewStatsByMonthLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12.0),
            if (sortedReviewsByMonth.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(localizations.reviewStatsNoMonthlyData, style: const TextStyle(fontStyle: FontStyle.italic)),
              )
            else
              AspectRatio(
                aspectRatio: 1.6,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: sortedReviewsByMonth.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble() + 2,
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value % 1 == 0 && value >=0) {
                              return Text(value.toInt().toString(), style: const TextStyle(fontSize: 10));
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            final int index = value.toInt();
                            if (index >= 0 && index < sortedReviewsByMonth.length) {
                              final String yearMonthKey = sortedReviewsByMonth[index].key;
                              try {
                                final year = int.parse(yearMonthKey.substring(0, 4));
                                final month = int.parse(yearMonthKey.substring(5, 7));
                                final dateForMonth = DateTime(year, month);
                                final String monthLabel = DateFormat.MMM(localizations.localeName).format(dateForMonth);
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(monthLabel, style: const TextStyle(fontSize: 10)),
                                );
                              } catch (e) {
                                print("Errore formattazione etichetta mese: $e per $yearMonthKey");
                                return const SizedBox.shrink();
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: sortedReviewsByMonth.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final double rodValue = entry.value.value.toDouble(); // Rinominato per evitare conflitto con 'value' di getTitlesWidget
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: rodValue,
                            color: Theme.of(context).colorScheme.primary,
                            width: 16,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    gridData: const FlGridData(show: true, drawVerticalLine: false),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}