import 'package:flutter/material.dart';

enum StyledButtonStyle { primary, secondary, tertiary }

class StyledButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final StyledButtonStyle style;

  const StyledButton({
    required this.onTap,
    this.style = StyledButtonStyle.primary,
    required this.text,
    super.key,
  });

  static const maxHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: maxHeight),
      child: Material(
        color: style.backgroundColor(context, _isEnabled),
        shape: StadiumBorder(
          side: BorderSide(
            color: style.borderColor(context, _isEnabled),
            width: 2.0,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Center(
              child: Text(
                text,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: style.textColor(context, _isEnabled),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _isEnabled => onTap != null;
}

extension _Styles on StyledButtonStyle {
  Color backgroundColor(BuildContext context, bool enabled) {
    switch (this) {
      case StyledButtonStyle.primary:
        return enabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.5);
      case StyledButtonStyle.secondary:
        return Colors.transparent;
      case StyledButtonStyle.tertiary:
        return Colors.transparent;
    }
  }

  Color borderColor(BuildContext context, bool enabled) {
    switch (this) {
      case StyledButtonStyle.primary:
        return Colors.transparent;
      case StyledButtonStyle.secondary:
        return enabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.5);
      case StyledButtonStyle.tertiary:
        return Colors.transparent;
    }
  }

  Color textColor(BuildContext context, bool enabled) {
    switch (this) {
      case StyledButtonStyle.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case StyledButtonStyle.secondary:
        return enabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.5);
      case StyledButtonStyle.tertiary:
        return enabled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.5);
    }
  }
}
