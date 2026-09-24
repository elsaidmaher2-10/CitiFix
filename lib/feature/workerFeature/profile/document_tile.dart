import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DocumentStatus { approved, pending, rejected }

extension DocumentStatusExt on DocumentStatus {
  Color get color {
    switch (this) {
      case DocumentStatus.approved:
        return ColorManger.success;
      case DocumentStatus.pending:
        return ColorManger.bgLight;
      case DocumentStatus.rejected:
        return ColorManger.error;
    }
  }

  IconData get icon {
    switch (this) {
      case DocumentStatus.approved:
        return Icons.check_circle;
      case DocumentStatus.pending:
        return Icons.hourglass_bottom;
      case DocumentStatus.rejected:
        return Icons.cancel;
    }
  }

  String get label {
    switch (this) {
      case DocumentStatus.approved:
        return 'APPROVED';
      case DocumentStatus.pending:
        return 'PENDING';
      case DocumentStatus.rejected:
        return 'REJECTED';
    }
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    super.key,
    required this.title,
    required this.icon,
    this.status = DocumentStatus.approved,
  });

  final String title;
  final Widget icon;
  final DocumentStatus status;

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case DocumentStatus.approved:
        return context.palette.success;
      case DocumentStatus.pending:
        return context.palette.onSurfaceVariant;
      case DocumentStatus.rejected:
        return context.palette.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.palette.surfaceLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.palette.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.palette.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: context.palette.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(status.icon, color: statusColor, size: 10),
                  const SizedBox(width: 4),
                  Text(
                    status.label,
                    style: GoogleFonts.cairo(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentsRow extends StatelessWidget {
  const DocumentsRow({super.key, required this.documents});

  final List<DocumentTileData> documents;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < documents.length; i++) ...[
          DocumentTile(
            title: documents[i].title,
            icon: documents[i].icon,
            status: documents[i].status,
          ),
          if (i < documents.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class DocumentTileData {
  const DocumentTileData({
    required this.title,
    required this.icon,
    this.status = DocumentStatus.approved,
  });

  final String title;
  final Widget icon;
  final DocumentStatus status;
}
