import 'package:flutter/material.dart';
import 'screens/patient_details_screen.dart';
import 'screens/health_metrics_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/health_tips_screen.dart';
import 'screens/splash_screen.dart';
import 'data/dummy_data.dart';

// ── Light Theme Color Palette ──
const kPurple = Color(0xFF6200EA); // Deep Purple
const kPurpleLight = Color(0xFFB388FF);
const kCyan = Color(0xFF00BCD4);
const kLightBg = Color(0xFFF4F7FC); // Very light blue/grey
const kLightSurface = Colors.white;
const kLightCard = Colors.white;
const kTextColor = Color(0xFF2D3142); // Dark grey text
const kTextLight = Color(0xFF9098B1); // Light grey text

void main() {
  runApp(const MyHealthTrackerApp());
}

// Root Application Widget
class MyHealthTrackerApp extends StatelessWidget {
  const MyHealthTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Health Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: kLightBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPurple,
          brightness: Brightness.light,
          surface: kLightSurface,
          background: kLightBg,
        ),
        cardColor: kLightCard,
        cardTheme: CardThemeData(
          color: kLightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: kTextColor,
          elevation: 0,
          centerTitle: true,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: kLightSurface,
        ),
        dividerColor: Colors.black12,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kLightSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: kPurple, width: 1.5),
          ),
          labelStyle: const TextStyle(color: kTextLight, fontSize: 14),
          prefixIconColor: kPurple,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const AppRoot(),
    );
  }
}

// ── Splash → Home Transition ──
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _showSplash = true;

  void _onGetStarted() {
    setState(() => _showSplash = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
      child: _showSplash
          ? SplashScreen(key: const ValueKey('splash'), onGetStarted: _onGetStarted)
          : const HomeScreen(key: ValueKey('home')),
    );
  }
}

// ── Main Home Screen with premium bottom nav ──
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    PatientDetailsScreen(), // Screen 1
    HealthMetricsScreen(),  // Screen 2
    AppointmentScreen(),    // Screen 3
    HealthTipsScreen(),     // Screen 4
  ];

  final List<String> _titles = const [
    'Patient Profile',
    'Health Metrics',
    'Book Appointment',
    'Health Tips',
  ];

  final List<IconData> _icons = const [
    Icons.person_rounded,
    Icons.monitor_heart_rounded,
    Icons.edit_calendar_rounded,
    Icons.tips_and_updates_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,

      // ── AppBar ──
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            color: kLightSurface,
            border: Border(
              bottom: BorderSide(color: Colors.black12, width: 1),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _titles[_currentIndex],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                    fontSize: 17,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            iconTheme: const IconThemeData(color: kTextColor),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: kPurple.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.info_outline_rounded, color: kPurple, size: 20),
                  tooltip: 'App Info',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('My Health Tracker v1.0 • Sarthak Tajane', style: TextStyle(color: Colors.white)),
                        backgroundColor: kPurple,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(16),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Drawer ──
      drawer: Drawer(
        backgroundColor: kLightSurface,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPurple, Color(0xFF00BCD4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.asset(
                            'assets/flower.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 36, color: Colors.white);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        PatientData.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${PatientData.age} • ${PatientData.bloodGroup} • ${PatientData.gender}',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            ..._buildDrawerItems(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Colors.black12),
            ),

            _buildDrawerTile(Icons.emergency_rounded, 'Emergency Helpline', 'Dial 112 / 108', Colors.red, () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: kLightSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  title: const Row(
                    children: [
                      Icon(Icons.emergency_rounded, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Emergency', style: TextStyle(color: kTextColor, fontSize: 16)),
                    ],
                  ),
                  content: const Text('Hospital Helpline: 108\nAmbulance: 102\nPolice: 100',
                      style: TextStyle(color: kTextColor, height: 1.6)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Close', style: TextStyle(color: kPurple)),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),

      // ── Body ──
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),

      // ── Premium Bottom Navigation ──
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kLightSurface,
          border: const Border(top: BorderSide(color: Colors.black12, width: 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 16 : 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? kPurple.withAlpha(20) : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _icons[index],
                          color: isSelected ? kPurple : kTextLight,
                          size: isSelected ? 24 : 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ['Patient', 'Metrics', 'Book', 'Tips'][index],
                          style: TextStyle(
                            color: isSelected ? kPurple : kTextLight,
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    final items = [
      {'icon': Icons.person_rounded, 'label': 'Patient Details', 'idx': 0},
      {'icon': Icons.monitor_heart_rounded, 'label': 'Health Metrics', 'idx': 1},
      {'icon': Icons.calendar_today_rounded, 'label': 'Book Appointment', 'idx': 2},
      {'icon': Icons.lightbulb_rounded, 'label': 'Health Tips', 'idx': 3},
    ];

    return items.map((item) {
      final idx = item['idx'] as int;
      final isActive = _currentIndex == idx;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: isActive ? kPurple.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(item['icon'] as IconData, color: isActive ? kPurple : kTextLight, size: 22),
          title: Text(
            item['label'] as String,
            style: TextStyle(
              color: isActive ? kPurple : kTextColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
          onTap: () { setState(() => _currentIndex = idx); Navigator.pop(context); },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          dense: true,
        ),
      );
    }).toList();
  }

  Widget _buildDrawerTile(IconData icon, String title, String sub, Color c, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        leading: Icon(icon, color: c, size: 22),
        title: Text(title, style: TextStyle(color: c, fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: TextStyle(color: kTextLight, fontSize: 12)),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        dense: true,
      ),
    );
  }
}
