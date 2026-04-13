import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class CustomerAppointmentScreen extends StatelessWidget {
  const CustomerAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: AppTheme.customerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Advisor Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.advisorColor.withValues(alpha: 0.1),
                    child: const Text('FH', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.advisorColor, fontSize: 16)),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fatima Hassan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        Text('Your Dedicated Advisor', style: TextStyle(fontSize: 13, color: Colors.grey)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: AppTheme.secondaryColor),
                            SizedBox(width: 2),
                            Text('4.9', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            Text(' • 8 years experience', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Meeting Type
            const Text('Select Meeting Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                _MeetingTypeCard(icon: Icons.video_call, label: 'Video Call', isSelected: true),
                const SizedBox(width: 12),
                _MeetingTypeCard(icon: Icons.phone, label: 'Phone Call', isSelected: false),
                const SizedBox(width: 12),
                _MeetingTypeCard(icon: Icons.location_on, label: 'In-Person', isSelected: false),
              ],
            ),
            const SizedBox(height: 24),

            // Date Selection
            const Text('Select Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _DateChip('Mon', '24', false),
                  _DateChip('Tue', '25', true),
                  _DateChip('Wed', '26', false),
                  _DateChip('Thu', '27', false),
                  _DateChip('Fri', '28', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Time Slots
            const Text('Available Time Slots', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _TimeSlot('9:00 AM', false),
                _TimeSlot('10:00 AM', true),
                _TimeSlot('11:00 AM', false),
                _TimeSlot('12:00 PM', false),
                _TimeSlot('2:00 PM', false),
                _TimeSlot('3:00 PM', false),
                _TimeSlot('4:00 PM', false),
              ],
            ),
            const SizedBox(height: 24),

            // Meeting Purpose
            const Text('Meeting Purpose', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'What would you like to discuss?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),

            // Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment booked successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.customerColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Book Appointment'),
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Appointments
            const SectionHeader(title: 'Upcoming Appointments'),
            const SizedBox(height: 8),
            _AppointmentItem(date: 'Feb 25, 2026', time: '10:00 AM', type: 'Video Call', purpose: 'Portfolio Review'),
            _AppointmentItem(date: 'Mar 10, 2026', time: '2:00 PM', type: 'In-Person', purpose: 'Annual Review'),
          ],
        ),
      ),
    );
  }
}

class _MeetingTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  const _MeetingTypeCard({required this.icon, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.customerColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppTheme.customerColor : Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey, size: 24),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  const _DateChip(this.day, this.date, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.customerColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? AppTheme.customerColor : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(day, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white70 : Colors.grey)),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black87)),
        ],
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final String time;
  final bool isSelected;
  const _TimeSlot(this.time, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.customerColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isSelected ? AppTheme.customerColor : Colors.grey.shade300),
      ),
      child: Text(time, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.grey.shade700)),
    );
  }
}

class _AppointmentItem extends StatelessWidget {
  final String date;
  final String time;
  final String type;
  final String purpose;
  const _AppointmentItem({required this.date, required this.time, required this.type, required this.purpose});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: AppTheme.customerColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.event, color: AppTheme.customerColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(purpose, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text('$date • $time • $type', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Reschedule', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
