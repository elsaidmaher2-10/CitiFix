import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resource/colormanager.dart';

class ActionListTile extends StatelessWidget {
  const ActionListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.palette.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: context.palette.workerprimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: context.palette.workerprimary, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.palette.onSurface,
                    ),
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: context.palette.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionList extends StatelessWidget {
  const ActionList({super.key, required this.actions});

  final List<ActionListTileData> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var action in actions)
          ActionListTile(
            icon: action.icon,
            label: action.label,
            onTap: action.onTap,
            trailing: action.trailing,
          ),
      ],
    );
  }
}

class ActionListTileData {
  const ActionListTileData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
}
