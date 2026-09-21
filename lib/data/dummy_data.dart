import 'package:flutter/material.dart';

// --- PATIENT DATA ---
// Simple hard-coded patient information
class PatientData {
  static const String name = 'Sarthak Tajane';
  static const String age = '20 Years';
  static const String gender = 'Male';
  static const String bloodGroup = 'AB+';
  static const String height = '172 cm';
  static const String weight = '67 kg';
  static const String emergencyContact = '+91 97661 56152';
  static const String allergies = 'Penicillin, Pollen';
}

// --- HEALTH METRIC ITEM ---
// Simple class to hold metric information
class HealthMetric {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const HealthMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
}

// Dummy list of health metrics for GridView
final List<HealthMetric> dummyMetrics = [
  const HealthMetric(
    title: 'Heart Rate',
    value: '74',
    unit: 'bpm',
    icon: Icons.favorite,
    color: Colors.red,
  ),
  const HealthMetric(
    title: 'Blood Pressure',
    value: '118/76',
    unit: 'mmHg',
    icon: Icons.speed,
    color: Colors.blue,
  ),
  const HealthMetric(
    title: 'Blood Sugar',
    value: '92',
    unit: 'mg/dL',
    icon: Icons.water_drop,
    color: Colors.orange,
  ),
  const HealthMetric(
    title: 'Water Intake',
    value: '3.2 / 3.5',
    unit: 'Liters',
    icon: Icons.local_drink,
    color: Colors.cyan,
  ),
  const HealthMetric(
    title: 'Daily Steps',
    value: '10,847',
    unit: 'steps',
    icon: Icons.directions_walk,
    color: Colors.green,
  ),
  const HealthMetric(
    title: 'Sleep',
    value: '7.8',
    unit: 'hours',
    icon: Icons.bedtime,
    color: Colors.deepPurple,
  ),
];

// --- HEALTH TIP ITEM ---
// Simple class to hold health advice tips
class HealthTip {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const HealthTip({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Dummy list of health tips for ListView
final List<HealthTip> dummyTips = [
  const HealthTip(
    title: 'Drink More Water Daily',
    description: 'Aim for at least 3–4 litres of water every day to boost metabolism, clear skin, and improve energy levels.',
    icon: Icons.water_drop_outlined,
    color: Colors.blue,
  ),
  const HealthTip(
    title: 'Hit 10,000 Steps a Day',
    description: 'Walking 10,000 steps daily improves cardiovascular health, burns calories, and keeps your mood elevated.',
    icon: Icons.directions_walk,
    color: Colors.green,
  ),
  const HealthTip(
    title: 'Eat Fresh Greens & Proteins',
    description: 'Include leafy greens, dal, eggs, or paneer in every meal to fuel muscle growth and keep energy steady.',
    icon: Icons.restaurant,
    color: Colors.orange,
  ),
  const HealthTip(
    title: 'Maintain Healthy Blood Pressure',
    description: 'Reduce salt intake, avoid stress, and exercise regularly to keep your BP within the 120/80 range.',
    icon: Icons.monitor_heart,
    color: Colors.purple,
  ),
  const HealthTip(
    title: 'Sleep 7–8 Hours Consistently',
    description: 'Quality sleep repairs muscles, sharpens focus, and keeps your immune system strong for the next day.',
    icon: Icons.nightlight_round,
    color: Colors.indigo,
  ),
  const HealthTip(
    title: 'Take Screen Breaks',
    description: 'Follow the 20-20-20 rule — every 20 minutes, look at something 20 feet away for 20 seconds to reduce eye strain.',
    icon: Icons.remove_red_eye_outlined,
    color: Colors.teal,
  ),
];

// Doctors list for DropdownButton
final List<String> doctorDepartments = [
  'General Physician - Dr. Arjun Mehta',
  'Cardiologist - Dr. Sneha Patil',
  'Dermatologist - Dr. Rohit Sharma',
  'Orthopedic - Dr. Kavya Joshi',
  'Dentist - Dr. Priya Kulkarni',
];
