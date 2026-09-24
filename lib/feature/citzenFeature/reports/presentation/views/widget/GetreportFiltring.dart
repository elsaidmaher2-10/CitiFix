import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FliterCheap extends StatelessWidget {
  const FliterCheap({super.key, required this.label, required this.isActive});
  final String label;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final Color primary = context.palette.kPrimary;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive
            ? primary
            : context.palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: primary.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: isActive
              ? Colors.transparent
              : context.palette.outline.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          color: isActive
              ? context.palette.onPrimary
              : context.palette.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
