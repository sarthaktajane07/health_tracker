import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

const kPurple = Color(0xFF6200EA);
const kLightCard = Colors.white;
const kTextColor = Color(0xFF2D3142);
const kTextLight = Color(0xFF9098B1);

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  State<HealthTipsScreen> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  final Set<int> _favoriteIndices = {0, 3};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
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
                  child: const Icon(Icons.lightbulb_rounded, color: kPurple, size: 18),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Wellness Tips & Advice',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      Text(
                        'Stay healthy with these expert tips',
                        style: TextStyle(fontSize: 11, color: kTextLight),
                      ),
                    ],
                  ),
                ),
                // Saved count badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.redAccent.withAlpha(40)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite, color: Colors.redAccent, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        '${_favoriteIndices.length}',
                        style: const TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── ListView with health tips ──
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dummyTips.length,
              itemBuilder: (context, index) {
                final tip = dummyTips[index];
                final isFav = _favoriteIndices.contains(index);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: kLightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isFav ? tip.color.withAlpha(60) : Colors.black.withAlpha(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isFav ? tip.color.withAlpha(10) : Colors.black.withAlpha(5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Tip Icon ──
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: tip.color.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(tip.icon, color: tip.color, size: 22),
                        ),
                        const SizedBox(width: 14),

                        // ── Tip Content ──
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tip.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tip.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: kTextLight,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 6),

                        // ── Favorite IconButton ──
                        Container(
                          decoration: BoxDecoration(
                            color: isFav ? Colors.redAccent.withAlpha(15) : Colors.black.withAlpha(5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: isFav ? Colors.redAccent : Colors.black26,
                              size: 20,
                            ),
                            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            padding: const EdgeInsets.all(6),
                            onPressed: () {
                              setState(() {
                                if (isFav) {
                                  _favoriteIndices.remove(index);
                                } else {
                                  _favoriteIndices.add(index);
                                }
                              });

                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(
                                        isFav ? Icons.bookmark_remove : Icons.bookmark_added,
                                        color: Colors.white, size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          isFav
                                              ? 'Removed "${tip.title}"'
                                              : 'Saved "${tip.title}" ✓',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: kPurple,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
