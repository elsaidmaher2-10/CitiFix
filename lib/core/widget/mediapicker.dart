import 'dart:io';
import 'package:citifix/core/resource/citifix_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

const Color kPrimary = Color(0xFF003366);
const Color kPrimaryLight = Color(0xFF1A4D8F);
const Color kPrimaryFaint = Color(0xFFE8EEF6);

class PickerBottomSheet extends StatefulWidget {
  final VoidCallback onCameraPhoto;
  final VoidCallback onCameraVideo;
  final void Function(List<File> files) onFilesSelected;

  const PickerBottomSheet({
    super.key,
    required this.onCameraPhoto,
    required this.onCameraVideo,
    required this.onFilesSelected,
  });

  @override
  State<PickerBottomSheet> createState() => _PickerBottomSheetState();
}

class _PickerBottomSheetState extends State<PickerBottomSheet> {
  List<AssetEntity> _assets = [];
  final List<AssetEntity> _selectedAssets = [];
  bool _loading = true;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _loadGallery();
  }

  Future<void> _loadGallery() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      setState(() {
        _permissionDenied = true;
        _loading = false;
      });
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: true,

      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      ),
    );

    if (albums.isEmpty) {
      setState(() => _loading = false);
      return;
    }

    final assets = await albums.first.getAssetListRange(start: 0, end: 500);
    setState(() {
      _assets = assets;
      _loading = false;
    });
  }

  void _toggleAsset(AssetEntity asset) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedAssets.contains(asset)) {
        _selectedAssets.remove(asset);
      } else {
        if (_selectedAssets.length < 30) {
          _selectedAssets.add(asset);
        }
      }
    });
  }

  Future<void> _confirmSelection() async {
    if (_selectedAssets.isEmpty) return;
    HapticFeedback.mediumImpact();

    final files = <File>[];
    for (final asset in _selectedAssets) {
      final file = await asset.file;
      if (file != null) files.add(file);
    }

    widget.onFilesSelected(files);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: palette.surfaceContainerLow,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              _DragHandle(),
              _CameraRow(
                onPhoto: widget.onCameraPhoto,
                onVideo: widget.onCameraVideo,
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: palette.outline.withValues(alpha: 0.2),
              ),
              _GalleryHeader(
                selectedCount: _selectedAssets.length,
                onAdd: _confirmSelection,
              ),
              Expanded(
                child: _GalleryBody(
                  loading: _loading,
                  permissionDenied: _permissionDenied,
                  assets: _assets,
                  selectedAssets: _selectedAssets,
                  scrollController: scrollController,
                  onToggle: _toggleAsset,
                ),
              ),
              if (_selectedAssets.isNotEmpty)
                _SelectedStrip(
                  selectedAssets: _selectedAssets,
                  onRemove: _toggleAsset,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: context.palette.outline.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _CameraRow extends StatelessWidget {
  final VoidCallback onPhoto;
  final VoidCallback onVideo;

  const _CameraRow({required this.onPhoto, required this.onVideo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _CameraButton(
              icon: Icons.photo_camera_rounded,
              label: 'Photo',
              onTap: onPhoto,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _CameraButton(
              icon: Icons.videocam_rounded,
              label: 'Video',
              onTap: onVideo,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CameraButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        decoration: BoxDecoration(
          color: palette.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: palette.outline.withValues(alpha: 0.18)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 30, color: palette.kPrimary),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: palette.kPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryHeader extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onAdd;

  const _GalleryHeader({required this.selectedCount, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gallery',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: palette.onSurface,
            ),
          ),
          if (selectedCount > 0)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: palette.kPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Add  $selectedCount',
                  style: GoogleFonts.cairo(
                    color: palette.onPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GalleryBody extends StatelessWidget {
  final bool loading;
  final bool permissionDenied;
  final List<AssetEntity> assets;
  final List<AssetEntity> selectedAssets;
  final ScrollController scrollController;
  final void Function(AssetEntity) onToggle;

  const _GalleryBody({
    required this.loading,
    required this.permissionDenied,
    required this.assets,
    required this.selectedAssets,
    required this.scrollController,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    if (loading) {
      return Center(child: CircularProgressIndicator(color: palette.kPrimary));
    }

    if (permissionDenied) {
      return _PermissionDeniedView();
    }

    if (assets.isEmpty) {
      return Center(
        child: Text(
          'No media found',
          style: GoogleFonts.cairo(
            color: palette.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
      );
    }

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 1.5,
      ),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        final selIdx = selectedAssets.indexOf(asset);
        final isSelected = selIdx != -1;
        return _GalleryTile(
          asset: asset,
          isSelected: isSelected,
          selectionNumber: isSelected ? selIdx + 1 : null,
          onTap: () => onToggle(asset),
        );
      },
    );
  }
}

class _SelectedStrip extends StatelessWidget {
  final List<AssetEntity> selectedAssets;
  final void Function(AssetEntity) onRemove;

  const _SelectedStrip({required this.selectedAssets, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      color: palette.surfaceContainerHigh,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
      child: SizedBox(
        height: 64,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: selectedAssets.length,
          separatorBuilder: (_, _) => const SizedBox(width: 6),
          itemBuilder: (context, i) {
            final asset = selectedAssets[i];
            return GestureDetector(
              onTap: () => onRemove(asset),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    AssetEntityImage(
                      asset,
                      isOriginal: false,
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: palette.kPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 11,
                          color: palette.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GalleryTile extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final int? selectionNumber;
  final VoidCallback onTap;

  const _GalleryTile({
    required this.asset,
    required this.isSelected,
    required this.selectionNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AssetEntityImage(
            asset,
            isOriginal: false,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: palette.surfaceContainerLow,
              child: Icon(
                Icons.broken_image,
                color: palette.onSurfaceVariant,
                size: 28,
              ),
            ),
          ),

          if (isSelected) Container(color: palette.kPrimary.withValues(alpha: 0.28)),

          if (asset.type == AssetType.video)
            Positioned(
              bottom: 4,
              left: 4,
              child: Row(
                children: [
                  const Icon(
                    Icons.videocam_rounded,
                    color: Colors.white,
                    size: 13,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    _fmt(asset.duration),
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      shadows: const [
                        Shadow(color: Colors.black54, blurRadius: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          Positioned(
            top: 5,
            right: 5,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? palette.kPrimary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? palette.kPrimary : Colors.white,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 3),
                ],
              ),
              child: isSelected
                  ? Center(
                      child: Text(
                        '$selectionNumber',
                        style: GoogleFonts.cairo(
                          color: palette.onPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

class _PermissionDeniedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, size: 52, color: palette.kPrimary),
          const SizedBox(height: 10),
          Text(
            'Gallery permission denied',
            style: GoogleFonts.cairo(
              color: palette.onSurfaceVariant,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: palette.kPrimary,
              foregroundColor: palette.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: PhotoManager.openSetting,
            child: Text(
              'Open Settings',
              style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
