import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Primary elevated button with loading state
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height = 52,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : child;

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(padding: padding),
          child: buttonChild,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(padding: padding),
        child: buttonChild,
      ),
    );
  }
}

/// Secondary outlined button
class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final double? width;
  final double height;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.width,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      isLoading: isLoading,
      isOutlined: true,
      width: width,
      height: height,
      child: child,
    );
  }
}

/// Text button with icon
class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Color? color;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(text, style: TextStyle(color: color)),
      );
    }

    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}

/// Icon button with background
class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = 48,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor ?? AppColors.textPrimary,
        ),
        iconSize: size * 0.5,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

/// Floating action button with extended label
class AppFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final bool mini;

  const AppFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.mini = false,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      mini: mini,
      child: Icon(icon),
    );
  }
}
