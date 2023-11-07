import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        Border,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Colors,
        Column,
        Container,
        EdgeInsets,
        Flexible,
        GestureDetector,
        Icon,
        Icons,
        MainAxisAlignment,
        MainAxisSize,
        Material,
        MaterialLocalizations,
        Navigator,
        Padding,
        SafeArea,
        StatelessWidget,
        Widget,
        WillPopScope,
        showGeneralDialog;

import '../../core/extensions/build_context_extensions.dart';
import '../../core/themes/app_theme_factory.dart';
import '../../core/themes/spacing/spacing.dart';

class CustomDialog {
  static Future<bool?> show(
    BuildContext context,
    Widget child, {
    bool showClose = false,
    EdgeInsets? padding,
  }) async {
    return await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (_, animation, secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async => false,
          child: _CustomDialog(
            showClose: showClose,
            padding: padding,
            child: child,
          ),
        );
      },
    );
  }
}

class _CustomDialog extends StatelessWidget {
  final bool showClose;
  final Widget child;
  final EdgeInsets? padding;

  const _CustomDialog({
    required this.showClose,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: context.theme.borderRadiusMD,
                  border: Border.all(
                    color: context.colorScheme.background,
                    width: 2,
                  ),
                  color: context.colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: -5,
                      color: context.colorScheme.background.withOpacity(0.5),
                    ),
                  ],
                ),
                padding: padding ?? EdgeInsets.all(const Spacing(2).value),
                margin: EdgeInsets.all(const Spacing(3).value),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showClose)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Icon(
                              Icons.close_rounded,
                              color: context.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                      ),
                    Flexible(child: child),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
