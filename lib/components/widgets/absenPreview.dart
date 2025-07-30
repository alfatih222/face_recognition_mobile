import 'package:flutter/material.dart';

enum AbsenStatus { hadir, pulang, tidakHadir }

class AbsenPreviewTile extends StatelessWidget {
  const AbsenPreviewTile({
    super.key,
    required this.clockInTime,
    required this.date,
    required this.status,
    required this.onTap,
  });

  final String clockInTime;
  final String date;
  final AbsenStatus status;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Jam Absen:'),
                    const SizedBox(width: 5),
                    Text(
                      clockInTime,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(date, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Status:'),
                    const SizedBox(width: 10),
                    _buildStatusBadge(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final color = _statusColor();
    final text = _statusText();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
    );
  }

  Color _statusColor() {
    switch (status) {
      case AbsenStatus.hadir:
        return Colors.green;
      case AbsenStatus.pulang:
        return Colors.blue;
      case AbsenStatus.tidakHadir:
        return Colors.red;
    }
  }

  String _statusText() {
    switch (status) {
      case AbsenStatus.hadir:
        return 'Masuk';
      case AbsenStatus.pulang:
        return 'Pulang';
      case AbsenStatus.tidakHadir:
        return 'Tidak Hadir';
    }
  }
}
