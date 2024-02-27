import 'package:flutter/material.dart';
import 'package:sale_inventory/features/items/ui/shared/styles.dart';
import 'package:sale_inventory/features/items/ui/shared/themes.dart';

class Button extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final Widget? icon;
  final bool isEnabled;
  final bool isEmojiText;
  final Function? onPressed;
  final double? fontSize;
  const Button(
      {super.key,
      this.text,
      this.iconData,
      this.icon,
      required this.onPressed,
      this.isEnabled = true,
      this.isEmojiText = false,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: isEnabled
          ? Styles.buttonStyle(context)
          : Styles.buttonStyleDisabled(context),
      onPressed: isEnabled
          ? () {
              // ignore: avoid_dynamic_calls
              onPressed?.call();
            }
          : null,
      child: text != null
          ? Text(
              text!.toUpperCase(),
              textAlign: TextAlign.center,
              style: isEmojiText
                  ? Styles.textStyleNormalBoldOnWidget()
                  : Styles.textStyleSmallOnWidget()
                      .copyWith(fontSize: fontSize),
            )
          : iconData != null
              ? Icon(
                  iconData,
                  color: Themes.colorTextLight,
                )
              : icon,
    );
  }
}
