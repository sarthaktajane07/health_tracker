import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

const kPurple = Color(0xFF6200EA);
const kCyan = Color(0xFF00BCD4);
const kLightCard = Colors.white;
const kLightBg = Color(0xFFF4F7FC);
const kTextColor = Color(0xFF2D3142);
const kTextLight = Color(0xFF9098B1);

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── 1. Profile Banner with Stack ──
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6200EA), Color(0xFF00BCD4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: kPurple.withAlpha(60),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      left: 20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(15),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.badge_outlined, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text('#ST-2026-21',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -44,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kLightBg,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundColor: kPurple,
                    child: Icon(Icons.person, size: 46, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 56),

          // ── Name & ID ──
          Center(
            child: Column(
              children: [
                const Text(
                  PatientData.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: kPurple.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kPurple.withAlpha(40)),
                  ),
                  child: const Text(
                    'Patient ID: #ST-2026-21',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── 2. Personal Information Card ──
          _buildGlassCard(
            title: 'Personal Information',
            icon: Icons.person_outline_rounded,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoChip(Icons.cake_rounded, 'Age', PatientData.age, const Color(0xFFFF7043)),
                _buildDividerVertical(),
                _buildInfoChip(Icons.wc_rounded, 'Gender', PatientData.gender, const Color(0xFF42A5F5)),
                _buildDividerVertical(),
                _buildInfoChip(Icons.bloodtype_rounded, 'Blood', PatientData.bloodGroup, const Color(0xFFEF5350)),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── 3. Physical Metrics Card ──
          _buildGlassCard(
            title: 'Physical Metrics',
            icon: Icons.accessibility_new_rounded,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoChip(Icons.straighten_rounded, 'Height', PatientData.height, const Color(0xFF66BB6A)),
                _buildDividerVertical(),
                _buildInfoChip(Icons.monitor_weight_rounded, 'Weight', PatientData.weight, const Color(0xFFAB47BC)),
                _buildDividerVertical(),
                _buildInfoChip(Icons.speed_rounded, 'BMI', '22.6', const Color(0xFF00BCD4)),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── 4. Emergency Card ──
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.redAccent.withAlpha(60)),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Medical Alert & Emergency',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                  ],
                ),
                const Divider(color: Colors.black12, height: 24),
                _emergencyRow(Icons.phone_rounded, 'Emergency', PatientData.emergencyContact),
                const SizedBox(height: 8),
                _emergencyRow(Icons.medication_rounded, 'Allergies', PatientData.allergies),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget _buildGlassCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: kLightCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withAlpha(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kPurple.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: kPurple, size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black12, height: 24),
          child,
        ],
      ),
    );
  }

  static Widget _buildInfoChip(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: kTextLight, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ],
    );
  }

  static Widget _buildDividerVertical() {
    return Container(width: 1, height: 50, color: Colors.black12);
  }

  static Widget _emergencyRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.redAccent.withAlpha(200), size: 16),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(color: kTextLight, fontSize: 13, fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: kTextColor, fontSize: 13, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
