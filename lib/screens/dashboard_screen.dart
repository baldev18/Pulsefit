import 'package:flutter/material.dart';

import '../models/health_category.dart';
import '../widgets/category_card.dart';
import '../widgets/stat_tile.dart';
import '../widgets/summary_header.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PulseFit'),
          actions: [
            IconButton(
              tooltip: 'Toggle theme',
              onPressed: onToggleTheme,
              icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: SummaryHeader(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  child: const TabBar(
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Daily Stats'),
                      Tab(text: 'Weekly Trends'),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _DailyStatsTab(),
                    _WeeklyTrendsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyStatsTab extends StatelessWidget {
  const _DailyStatsTab();

  @override
  Widget build(BuildContext context) {
    final categories = HealthCategory.samples;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final crossAxisCount = screenWidth >= 700 ? 4 : 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: screenWidth < 380 ? 0.95 : 1.08,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(
                category: category,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(category: category),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Today Summary',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          const StatTile(
            icon: Icons.local_fire_department_rounded,
            title: 'Calories Burned',
            value: '540',
            subtitle: 'Goal: 650 kcal',
          ),
          const SizedBox(height: 12),
          const StatTile(
            icon: Icons.nightlight_round,
            title: 'Sleep Quality',
            value: '82%',
            subtitle: '7h 35m total sleep',
          ),
          const SizedBox(height: 12),
          const StatTile(
            icon: Icons.water_drop_rounded,
            title: 'Water Intake',
            value: '1.8L',
            subtitle: 'Target: 3L per day',
          ),
        ],
      ),
    );
  }
}

class _WeeklyTrendsTab extends StatelessWidget {
  const _WeeklyTrendsTab();

  @override
  Widget build(BuildContext context) {
    final trends = [
      ('Mon', 0.45, '4,500 steps'),
      ('Tue', 0.68, '6,800 steps'),
      ('Wed', 0.76, '7,600 steps'),
      ('Thu', 0.58, '5,800 steps'),
      ('Fri', 0.90, '9,000 steps'),
      ('Sat', 0.82, '8,200 steps'),
      ('Sun', 0.72, '7,200 steps'),
    ];

    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Weekly Step Trend',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              for (final trend in trends) ...[
                _TrendRow(day: trend.$1, progress: trend.$2, value: trend.$3),
                if (trend != trends.last) const SizedBox(height: 14),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        const StatTile(
          icon: Icons.trending_up_rounded,
          title: 'Best Day',
          value: 'Fri',
          subtitle: 'You completed 90% of your step goal.',
        ),
        const SizedBox(height: 12),
        const StatTile(
          icon: Icons.monitor_heart_rounded,
          title: 'Average Heart Rate',
          value: '76 bpm',
          subtitle: 'Healthy resting range this week.',
        ),
      ],
    );
  }
}

class _TrendRow extends StatelessWidget {
  const _TrendRow({
    required this.day,
    required this.progress,
    required this.value,
  });

  final String day;
  final double progress;
  final String value;

  Color _progressColor(double value) {
    if (value >= 0.80) return const Color(0xFF27AE60);
    if (value >= 0.50) return const Color(0xFFF39C12);
    return const Color(0xFFE74C3C);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Text(
            day,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(_progressColor(progress)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 86,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
