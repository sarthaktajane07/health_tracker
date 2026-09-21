import 'package:flutter/material.dart';
import 'dart:math' as math;

const kPurple = Color(0xFF6200EA);
const kCyan = Color(0xFF00BCD4);
const kLightBg = Color(0xFFF4F7FC);
const kTextColor = Color(0xFF2D3142);
const kTextLight = Color(0xFF9098B1);

class SplashScreen extends StatefulWidget {
  final VoidCallback onGetStarted;
  const SplashScreen({super.key, required this.onGetStarted});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _rotateController;

  late Animation<double> _pulseAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();

    // Pulse ring animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Slow rotation for decorative ring
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );

    // Fade in content
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _fadeController.forward();
    });

    // Slide up for button
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _slideController.forward();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLightBg,
      body: Stack(
        children: [
          // ── Background decorative circles ──
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPurple.withAlpha(15),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kCyan.withAlpha(15),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.35,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPurple.withAlpha(10),
              ),
            ),
          ),

          // ── Main Content ──
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Logo / Hero Icon
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rotating dashed ring
                        AnimatedBuilder(
                          animation: _rotateAnim,
                          builder: (_, __) => Transform.rotate(
                            angle: _rotateAnim.value,
                            child: CustomPaint(
                              size: const Size(160, 160),
                              painter: _DashedCirclePainter(
                                color: kPurple.withAlpha(60),
                                strokeWidth: 1.5,
                                dashCount: 24,
                              ),
                            ),
                          ),
                        ),
                        // Pulse outer glow
                        ScaleTransition(
                          scale: _pulseAnim,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  kPurple.withAlpha(30),
                                  kPurple.withAlpha(0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Icon container
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [kPurple, kCyan],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPurple.withAlpha(80),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // App Name
                FadeTransition(
                  opacity: _fadeAnim,
                  child: const Column(
                    children: [
                      Text(
                        'HealthTracker',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'by Sarthak Tajane',
                        style: TextStyle(
                          fontSize: 13,
                          color: kPurple,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Tagline
                FadeTransition(
                  opacity: _fadeAnim,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Monitor your vitals, track your wellness,\nand stay ahead of your health.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: kTextLight,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Feature chips
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _featureChip(Icons.monitor_heart, 'Vitals'),
                      _featureChip(Icons.directions_walk, 'Activity'),
                      _featureChip(Icons.calendar_month, 'Appointments'),
                      _featureChip(Icons.lightbulb_outline, 'Health Tips'),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // Get Started button
                SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [kPurple, kCyan],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: kPurple.withAlpha(60),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: widget.onGetStarted,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Footer
                FadeTransition(
                  opacity: _fadeAnim,
                  child: const Text(
                    'Your health data stays private & secure',
                    style: TextStyle(fontSize: 12, color: kTextLight),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPurple.withAlpha(40)),
        boxShadow: [
          BoxShadow(
            color: kPurple.withAlpha(10),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: kPurple, size: 15),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: kTextColor, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// Custom painter for a dashed circle ring
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final dashAngle = (2 * math.pi) / dashCount;
    final gapFraction = 0.4;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
