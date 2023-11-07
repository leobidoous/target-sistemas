import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/themes/app_theme_base.dart';
import '../../../core/themes/app_theme_factory.dart';
import '../../../core/themes/spacing/spacing.dart';
import '../../../core/themes/typography/typography_constants.dart';

enum ButtonType { primary, secondary, tertiary, background, noShape }

enum ButtonHeightType { normal, small }

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isEnabled = true,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
    this.isSafe = false,
    this.type = ButtonType.primary,
    this.heightType = ButtonHeightType.normal,
  });

  final ButtonType type;
  final ButtonHeightType heightType;
  final Function()? onPressed;
  final Widget child;
  final bool isEnabled;
  final bool isLoading;
  final bool isSafe;
  final EdgeInsets padding;

  @override
  State<CustomButton> createState() => _CustomButtonState();

  static Widget iconValue(
    IconData iconData, {
    ButtonType type = ButtonType.primary,
  }) {
    return Builder(
      builder: (context) {
        late final Color color;
        switch (type) {
          case ButtonType.background:
            color = context.colorScheme.primary;
            break;
          case ButtonType.noShape:
            color = context.colorScheme.primary;
            break;
          default:
            color = context.isDarkMode
                ? context.colorScheme.onBackground
                : context.colorScheme.background;
            break;
        }
        return Icon(
          iconData,
          size: AppFontSize.iconButton.value,
          color: color,
        );
      },
    );
  }

  static Widget textValue(
    String text, {
    ButtonType type = ButtonType.primary,
    ButtonHeightType heightType = ButtonHeightType.normal,
  }) {
    return Builder(
      builder: (context) {
        late final Color color;
        late final double? fontSize;
        switch (type) {
          case ButtonType.background:
            color = context.colorScheme.primary;
            break;
          case ButtonType.noShape:
            color = context.colorScheme.primary;
            break;
          default:
            color = context.isDarkMode
                ? context.colorScheme.onBackground
                : context.colorScheme.background;
            break;
        }
        switch (heightType) {
          case ButtonHeightType.normal:
            fontSize = context.textTheme.bodyMedium?.fontSize;
            break;
          case ButtonHeightType.small:
            fontSize = context.textTheme.bodySmall?.fontSize;
            break;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightBold,
                fontSize: fontSize,
                color: color,
              ),
            ),
          ],
        );
      },
    );
  }

  factory CustomButton.text({
    ButtonType type = ButtonType.primary,
    ButtonHeightType heightType = ButtonHeightType.normal,
    Function()? onPressed,
    required String text,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      type: type,
      onPressed: onPressed,
      heightType: heightType,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.sm.value),
        child: textValue(text, type: type),
      ),
    );
  }
  factory CustomButton.icon({
    ButtonType type = ButtonType.primary,
    ButtonHeightType heightType = ButtonHeightType.normal,
    Function()? onPressed,
    required IconData icon,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      type: type,
      onPressed: onPressed,
      heightType: heightType,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: iconValue(icon, type: type),
    );
  }
  factory CustomButton.iconText({
    ButtonType type = ButtonType.primary,
    ButtonHeightType heightType = ButtonHeightType.normal,
    Function()? onPressed,
    required IconData icon,
    required String text,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      type: type,
      onPressed: onPressed,
      heightType: heightType,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          iconValue(icon, type: type),
          Spacing.sm.horizontal,
          textValue(text, type: type),
        ],
      ),
    );
  }
}

class _CustomButtonState extends State<CustomButton> {
  Size get minimumSize {
    switch (widget.heightType) {
      case ButtonHeightType.normal:
        return Size(
          AppThemeBase.buttonHeightMD,
          AppThemeBase.buttonHeightMD,
        );
      case ButtonHeightType.small:
        return Size(
          AppThemeBase.buttonHeightSM,
          AppThemeBase.buttonHeightSM,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !widget.isEnabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: widget.isLoading || !widget.isEnabled,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_backgroundColor),
            surfaceTintColor: MaterialStateProperty.all(_surfaceTintColor),
            overlayColor: MaterialStateProperty.all(_overlayColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: context.theme.borderRadiusLG,
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(
              BorderSide(
                color: _borderColor,
                width: context.theme.borderWidthXS,
              ),
            ),
            minimumSize: MaterialStateProperty.all(minimumSize),
            elevation: MaterialStateProperty.all(5),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(widget.padding),
          ),
          child: SafeArea(
            bottom: widget.isSafe,
            top: false,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: const Spacing(1).value,
                vertical: const Spacing(.75).value,
              ),
              constraints: BoxConstraints(minHeight: minimumSize.height),
              child: widget.isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: context.colorScheme.background,
                      color: context.colorScheme.primary,
                      strokeWidth: 2,
                    )
                  : widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return Colors.transparent;
      case ButtonType.noShape:
        return Colors.transparent;
      case ButtonType.tertiary:
        return context.colorScheme.tertiary;
    }
  }

  Color get _surfaceTintColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return context.colorScheme.background;
      case ButtonType.tertiary:
        return context.colorScheme.tertiary;
      case ButtonType.noShape:
        return context.colorScheme.background;
    }
  }

  Color get _overlayColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.onPrimary.withOpacity(.1);
      case ButtonType.secondary:
        return context.colorScheme.onSecondary.withOpacity(.1);
      case ButtonType.background:
        return context.colorScheme.onBackground.withOpacity(.1);
      case ButtonType.noShape:
        return context.colorScheme.onBackground.withOpacity(.1);
      case ButtonType.tertiary:
        return context.colorScheme.tertiary.withOpacity(.1);
    }
  }

  Color get _borderColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return context.colorScheme.primary;
      case ButtonType.tertiary:
        return context.colorScheme.tertiary;
      case ButtonType.noShape:
        return Colors.transparent;
    }
  }
}
