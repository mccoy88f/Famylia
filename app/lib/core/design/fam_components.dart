import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Famylia design system — thin wrappers around shadcn_ui components
/// that apply consistent styling, spacing, and theming for the app.

// ── Card ──────────────────────────────────────────────────────────────────

class FamCard extends StatelessWidget {
  const FamCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: padding,
      child: onTap != null
          ? InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12), child: child)
          : child,
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────

class FamSectionHeader extends StatelessWidget {
  const FamSectionHeader(this.title, {super.key, this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: ShadTheme.of(context).textTheme.muted.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ── Input ─────────────────────────────────────────────────────────────────

class FamInput extends StatelessWidget {
  const FamInput({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.leading,
    this.trailing,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Widget? leading;
  final Widget? trailing;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: ShadTheme.of(context).textTheme.small.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
        ],
        ShadInput(
          controller: controller,
          placeholder: placeholder != null ? Text(placeholder!) : null,
          autofocus: autofocus,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          leading: leading,
          trailing: trailing,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
        ),
      ],
    );
  }
}

// ── Badge ─────────────────────────────────────────────────────────────────

class FamBadge extends StatelessWidget {
  const FamBadge(this.label, {super.key, this.variant = ShadBadgeVariant.secondary});
  final String label;
  final ShadBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    return ShadBadge.raw(
      variant: variant,
      child: Text(label),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────

class FamAvatar extends StatelessWidget {
  const FamAvatar({super.key, required this.initials, this.size = 36.0, this.color});
  final String initials;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final bg = color ?? shadTheme.colorScheme.muted;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              fontSize: size * 0.38,
              fontWeight: FontWeight.w600,
              color: shadTheme.colorScheme.mutedForeground,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────

class FamEmptyState extends StatelessWidget {
  const FamEmptyState({super.key, required this.icon, required this.message, this.action});
  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final muted = ShadTheme.of(context).colorScheme.mutedForeground;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: muted),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: ShadTheme.of(context).textTheme.muted,
            ),
            if (action != null) ...[const SizedBox(height: 20), action!],
          ],
        ),
      ),
    );
  }
}
