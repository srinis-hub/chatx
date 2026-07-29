import 'package:flutter/material.dart';

class AIBehaviorTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon icon;
  final VoidCallback onTap;

  const AIBehaviorTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: icon,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subTitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
