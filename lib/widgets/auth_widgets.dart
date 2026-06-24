import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import 'buttons.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscure = false,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.normal.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          style: AppTextStyles.normal,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.small.copyWith(
              color: Colors.white.withValues(alpha: 0.50),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 8),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthPanel extends StatelessWidget {
  const AuthPanel({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 385),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(43, 40, 43, 34),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.95),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 36),
            ...children,
          ],
        ),
      ),
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({this.onGoogleTap, this.onPhoneTap, super.key});

  final VoidCallback? onGoogleTap;
  final VoidCallback? onPhoneTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onGoogleTap,
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'G',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Sign in with Google',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 44,
          child: PrimaryButton(
            label: '',
            icon: Icons.phone,
            height: 44,
            onPressed: onPhoneTap,
          ),
        ),
      ],
    );
  }
}
