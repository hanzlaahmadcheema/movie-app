import 'dart:math' as math;

import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  const PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxVisiblePages = 5,
    super.key,
  });

  final int currentPage;
  final int totalPages;
  final int maxVisiblePages;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final normalizedTotal = math.max(1, totalPages);
    final normalizedCurrent = currentPage.clamp(1, normalizedTotal);
    final visibleCount = math.min(maxVisiblePages, normalizedTotal);
    final start = math.max(
      1,
      math.min(
        normalizedCurrent - (visibleCount ~/ 2),
        normalizedTotal - visibleCount + 1,
      ),
    );
    final pages = List<int>.generate(visibleCount, (index) => start + index);

    return SizedBox(
      height: 40,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _withSpacing([
            _PageIconButton(
              icon: Icons.chevron_left,
              enabled: normalizedCurrent > 1,
              onTap: () => onPageChanged(normalizedCurrent - 1),
            ),
            ...pages.map(
              (page) => _PageNumberButton(
                page: page,
                selected: page == normalizedCurrent,
                onTap: () => onPageChanged(page),
              ),
            ),
            _PageIconButton(
              icon: Icons.chevron_right,
              enabled: normalizedCurrent < normalizedTotal,
              onTap: () => onPageChanged(normalizedCurrent + 1),
            ),
          ]),
        ),
      ),
    );
  }

  List<Widget> _withSpacing(List<Widget> children) {
    return [
      for (var index = 0; index < children.length; index += 1) ...[
        if (index > 0) const SizedBox(width: 4),
        children[index],
      ],
    ];
  }
}

class _PageIconButton extends StatelessWidget {
  const _PageIconButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF242426),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.32),
          size: 22,
        ),
      ),
    );
  }
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    required this.page,
    required this.selected,
    required this.onTap,
  });

  final int page;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0FEFFD) : const Color(0xFF242426),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: selected ? const Color(0xFF111111) : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
