import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

const kPurple = Color(0xFF6200EA);
const kCyan = Color(0xFF00BCD4);
const kLightCard = Colors.white;
const kTextColor = Color(0xFF2D3142);
const kTextLight = Color(0xFF9098B1);

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Sarthak Tajane');
  final TextEditingController _phoneController = TextEditingController(text: '9766156152');
  final TextEditingController _reasonController = TextEditingController();

  String _selectedDoctor = doctorDepartments.first;
  String _consultationMode = 'In-Person';
  bool _isFirstTimeVisit = false;
  bool _smsReminder = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: kLightCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20),
              ),
              const SizedBox(width: 10),
              const Text('Confirm Booking', style: TextStyle(color: kTextColor, fontSize: 16)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogRow(Icons.person_rounded, 'Patient', _nameController.text),
              _dialogRow(Icons.medical_services_rounded, 'Doctor', _selectedDoctor.split(' - ').last),
              _dialogRow(Icons.videocam_rounded, 'Mode', _consultationMode),
              _dialogRow(Icons.new_releases_rounded, 'First Visit', _isFirstTimeVisit ? "Yes" : "No"),
              _dialogRow(Icons.sms_rounded, 'SMS Reminder', _smsReminder ? "Enabled" : "Disabled"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: kTextLight)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [kPurple, Color(0xFF536DFE)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Booked with ${_selectedDoctor.split(' - ').last}!')),
                        ],
                      ),
                      backgroundColor: kPurple,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: kPurple, size: 16),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(color: kTextLight, fontSize: 13, fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(color: kTextColor, fontSize: 13, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPurple.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_month_rounded, color: kPurple, size: 18),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Doctor Appointment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
                  ),
                  Text(
                    'Fill in your details below',
                    style: TextStyle(fontSize: 11, color: kTextLight),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Section Label ──
          _sectionLabel('Patient Details'),
          const SizedBox(height: 10),

          // 1. Patient Name TextField
          TextField(
            controller: _nameController,
            style: const TextStyle(color: kTextColor, fontSize: 14),
            decoration: const InputDecoration(
              labelText: 'Patient Full Name',
              prefixIcon: Icon(Icons.person_rounded, size: 20),
            ),
          ),
          const SizedBox(height: 12),

          // 2. Contact Phone TextField
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: kTextColor, fontSize: 14),
            decoration: const InputDecoration(
              labelText: 'Contact Number',
              prefixIcon: Icon(Icons.phone_rounded, size: 20),
            ),
          ),

          const SizedBox(height: 20),

          // ── Doctor Selection ──
          _sectionLabel('Select Doctor'),
          const SizedBox(height: 10),

          // 3. DropdownButton
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: kLightCard,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedDoctor,
                dropdownColor: kLightCard,
                borderRadius: BorderRadius.circular(14),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kPurple),
                style: const TextStyle(color: kTextColor, fontSize: 13, fontWeight: FontWeight.w600),
                items: doctorDepartments.map((String doctor) {
                  return DropdownMenuItem<String>(
                    value: doctor,
                    child: Row(
                      children: [
                        const Icon(Icons.medical_services_outlined, color: kPurple, size: 16),
                        const SizedBox(width: 10),
                        Expanded(child: Text(doctor)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) setState(() => _selectedDoctor = newValue);
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Consultation Mode ──
          _sectionLabel('Consultation Mode'),
          const SizedBox(height: 6),

          // 4. Radio Buttons
          RadioGroup<String>(
            groupValue: _consultationMode,
            onChanged: (String? value) {
              if (value != null) setState(() => _consultationMode = value);
            },
            child: Row(
              children: [
                _buildRadioChip('In-Person', Icons.local_hospital_rounded),
                const SizedBox(width: 10),
                _buildRadioChip('Online', Icons.videocam_rounded),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Preferences Section ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kLightCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                // 5. Checkbox
                Row(
                  children: [
                    SizedBox(
                      width: 22, height: 22,
                      child: Checkbox(
                        value: _isFirstTimeVisit,
                        activeColor: kPurple,
                        checkColor: Colors.white,
                        side: const BorderSide(color: Colors.black26),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (bool? value) => setState(() => _isFirstTimeVisit = value ?? false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text('First-time visit to this clinic',
                          style: TextStyle(color: kTextColor, fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const Divider(color: Colors.black12, height: 20),
                // 6. Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.sms_rounded, color: kPurple, size: 16),
                        SizedBox(width: 8),
                        Text('SMS Reminder', style: TextStyle(fontSize: 13, color: kTextColor, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: _smsReminder,
                        activeColor: kPurple,
                        activeTrackColor: kPurple.withAlpha(80),
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade200,
                        onChanged: (bool value) => setState(() => _smsReminder = value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 7. Submit Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kPurple, Color(0xFF00BCD4)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: kPurple.withAlpha(40),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text('Please fill out all required fields!'),
                          ],
                        ),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                    return;
                  }
                  _showConfirmationDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 20),
                label: const Text('Book Appointment',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: kPurple,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildRadioChip(String value, IconData icon) {
    final isSelected = _consultationMode == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _consultationMode = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? kPurple.withAlpha(20) : kLightCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? kPurple : Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: value,
                groupValue: _consultationMode,
                activeColor: kPurple,
                visualDensity: VisualDensity.compact,
                onChanged: (v) { if (v != null) setState(() => _consultationMode = v); },
              ),
              Icon(icon, color: isSelected ? kPurple : kTextLight, size: 16),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  color: isSelected ? kPurple : kTextLight,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
