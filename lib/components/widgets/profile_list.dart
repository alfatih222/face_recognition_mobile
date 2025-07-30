import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  final void Function() onTap;
  final Widget icon; // 🔄 Ubah dari String ke Widget
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon, // 🔄 Sekarang menerima widget langsung
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
