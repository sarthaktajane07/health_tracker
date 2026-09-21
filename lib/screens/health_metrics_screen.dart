import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

const kPurple = Color(0xFF6200EA);
const kLightCard = Colors.white;
const kTextColor = Color(0xFF2D3142);
const kTextLight = Color(0xFF9098B1);

class HealthMetricsScreen extends StatelessWidget {
  const HealthMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Header ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPurple.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.monitor_heart_rounded, color: kPurple, size: 18),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Vitals & Metrics',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      'Real-time health tracking',
                      style: TextStyle(fontSize: 11, color: kTextLight),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── GridView with health metric cards ──
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dummyMetrics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final metric = dummyMetrics[index];

                return Container(
                  decoration: BoxDecoration(
                    color: kLightCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: metric.color.withAlpha(60)),
                    boxShadow: [
                      BoxShadow(
                        color: metric.color.withAlpha(15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        right: -10,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: metric.color.withAlpha(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: metric.color.withAlpha(20),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(metric.icon, color: metric.color, size: 18),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    metric.title,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: kTextLight,
                                      letterSpacing: 0.3,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  metric.value,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: metric.color,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: metric.color.withAlpha(15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    metric.unit,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: metric.color.withAlpha(255),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
