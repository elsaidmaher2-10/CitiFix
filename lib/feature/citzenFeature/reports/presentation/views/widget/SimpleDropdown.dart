import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/categortrepos/categoryrepos.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/categoryManger/category_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/categoryManger/category_state.dart';
import 'package:citifix/generated/l10n.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(CategoryItem?)? onChanged;
  final ValueNotifier<CategoryItem?>? controller;
  final String? hintText;
  const CategoryDropdown({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late ValueNotifier<CategoryItem?> _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ValueNotifier<CategoryItem?>(null);
  }

  @override
  Widget build(BuildContext context) {
    final String currentLang = Localizations.localeOf(context).languageCode;
    return BlocProvider(
      key: ValueKey(currentLang),
      create: (_) => CategoryCubit(
        CategoryRepository(
          service: getIt<Apiservice>(),
          internetChecker: getIt<InternetChecker>(),
        ),
      )..getCachedCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          List<CategoryItem> items = [];
          String hint = widget.hintText ?? S.of(context).selectCategoryHint;
          if (state is CategoryLoading) {
            hint = S.of(context).loadingCategories;
          } else if (state is CategoryLoaded) {
            items = state.categories;
          } else if (state is CategoryError) {
            hint = S.of(context).failedToLoadCategories;
          }
          return ValueListenableBuilder<CategoryItem?>(
            valueListenable: _controller,
            builder: (context, selectedItem, child) {
              return InkWell(
                onTap: items.isEmpty
                    ? null
                    : () => _showSearchBottomSheet(context, items),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.surfaceContainerHighest
                        : const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)
                          : Colors.grey.shade300,
                      width: Theme.of(context).brightness == Brightness.dark ? 0.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedItem?.name ?? hint,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: selectedItem == null
                              ? FontWeight.normal
                              : FontWeight.w500,
                          color: selectedItem == null
                              ? context.palette.onSurfaceVariant.withValues(alpha: 0.6)
                              : context.palette.onSurface,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: context.palette.kPrimary,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context, List<CategoryItem> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return _SearchListWidget(
          items: items,
          searchHintText: S.of(context).searchHint,
          noResultText: S.of(context).noResult,
          onItemSelected: (item) {
            _controller.value = item;
            if (widget.onChanged != null) {
              widget.onChanged!(item);
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class _SearchListWidget extends StatefulWidget {
  final List<CategoryItem> items;
  final Function(CategoryItem) onItemSelected;
  final String searchHintText;
  final String noResultText;

  const _SearchListWidget({
    required this.items,
    required this.onItemSelected,
    required this.searchHintText,
    required this.noResultText,
  });

  @override
  State<_SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<_SearchListWidget> {
  late List<CategoryItem> filteredItems;

  @override
  void initState() {
    filteredItems = widget.items;
    super.initState();
  }

  void _filter(String query) {
    setState(() {
      filteredItems = widget.items.where((item) {
        return item.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.6,
        child: Column(
          children: [
            TextField(
              onChanged: _filter,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: context.palette.onSurface,
              ),
              decoration: InputDecoration(
                hintText: widget.searchHintText,
                hintStyle: GoogleFonts.cairo(
                  fontSize: 14,
                  color: context.palette.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                prefixIcon: Icon(Icons.search, color: context.palette.kPrimary),
                filled: true,
                fillColor: context.palette.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.palette.kPrimary.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.palette.kPrimary.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.palette.kPrimary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        widget.noResultText,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: context.palette.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredItems.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: context.palette.outline.withValues(alpha: 0.2)),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return ListTile(
                          title: Text(
                            item.name ?? '',
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              color: context.palette.onSurface,
                            ),
                          ),
                          onTap: () => widget.onItemSelected(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
