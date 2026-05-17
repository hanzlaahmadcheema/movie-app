import 'package:flutter/material.dart';

import '../app/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    this.icon,
    this.onPressed,
    this.height = 44,
    this.radius = 7,
    this.iconSize = 14,
    this.textStyle,
    super.key,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double height;
  final double radius;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: textStyle ?? AppTextStyles.button,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: iconSize),
                if (label.isNotEmpty) const SizedBox(width: 6),
              ],
              if (label.isNotEmpty) Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryMuted,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: AppTextStyles.tag.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class WatchlistButton extends StatefulWidget {
  const WatchlistButton({this.active, this.onChanged, this.onTap, super.key});

  final bool? active;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  @override
  State<WatchlistButton> createState() => _WatchlistButtonState();
}

class _WatchlistButtonState extends State<WatchlistButton> {
  bool internalActive = false;

  bool get active => widget.active ?? internalActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      child: Icon(
        active ? Icons.bookmark : Icons.bookmark_border,
        color: active ? AppColors.primary : Colors.white,
        size: 20,
      ),
    );
  }

  void _toggle() {
    final nextValue = !active;
    if (widget.active == null) {
      setState(() => internalActive = nextValue);
    }

    widget.onChanged?.call(nextValue);
    widget.onTap?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          nextValue ? 'Added to watchlist' : 'Removed from watchlist',
        ),
      ),
    );
  }
}
