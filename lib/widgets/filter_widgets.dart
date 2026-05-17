import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import 'buttons.dart';

class FilterSelection {
  const FilterSelection({
    required this.type,
    required this.genre,
    required this.releaseYear,
    required this.rating,
  });

  final String type;
  final String genre;
  final String releaseYear;
  final String rating;
}

class FilterPanel extends StatefulWidget {
  const FilterPanel({this.onApply, super.key});

  final ValueChanged<FilterSelection>? onApply;

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String type = 'Movies';
  String genre = 'Comedy';
  String releaseYear = '2022';
  String rating = 'PG-13';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterTile(
          label: 'Type',
          value: type,
          options: const ['Movies', 'TV Series'],
          onSelected: (value) => setState(() => type = value),
        ),
        const SizedBox(height: 10),
        FilterTile(
          label: 'Genre',
          value: genre,
          options: const ['Action', 'Comedy', 'Drama', 'Horror', 'Fantasy'],
          onSelected: (value) => setState(() => genre = value),
        ),
        const SizedBox(height: 10),
        FilterTile(
          label: 'Release Year',
          value: releaseYear,
          options: const ['2026', '2025', '2024', '2023', '2022', '2021'],
          onSelected: (value) => setState(() => releaseYear = value),
        ),
        const SizedBox(height: 10),
        FilterTile(
          label: 'Rating',
          value: rating,
          options: const ['G', 'PG', 'PG-13', 'R', 'TV-MA'],
          onSelected: (value) => setState(() => rating = value),
        ),
        const SizedBox(height: 14),
        PrimaryButton(
          label: 'Filter',
          icon: Icons.filter_alt,
          height: 53,
          radius: 25,
          iconSize: 16,
          textStyle: AppTextStyles.medium.copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
          onPressed: () {
            final selection = FilterSelection(
              type: type,
              genre: genre,
              releaseYear: releaseYear,
              rating: rating,
            );

            if (widget.onApply != null) {
              widget.onApply!(selection);
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Filtering ${selection.type.toLowerCase()} by ${selection.genre}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class FilterTile extends StatelessWidget {
  const FilterTile({
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
    super.key,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOptions(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 53,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.tag.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 22),
          ],
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: StatefulBuilder(
          builder: (context, setModalState) {
            var selectedValue = value;

            return ListView(
              shrinkWrap: true,
              children: options
                  .map(
                    (option) => ListTile(
                      title: Text(
                        option,
                        style: AppTextStyles.normal.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                      trailing: option == selectedValue
                          ? const Icon(Icons.check, color: AppColors.primary)
                          : null,
                      onTap: () {
                        setModalState(() => selectedValue = option);
                        onSelected(option);
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
