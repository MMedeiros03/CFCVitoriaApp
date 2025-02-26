import 'package:cfc_vitoria_app/Widgets/base_text_widget.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.showButton = true,
      this.widget = double.infinity,
      required this.backgroundColor,
      this.colorFont,
      this.shape,
      this.width,
      this.heigth,
      this.personalizedBorder = false,
      this.colorBorder,
      this.fontSize});

  final double? width;
  final double? heigth;
  final VoidCallback? onPressed;
  final String text;
  final bool showButton;
  final double widget;
  final Color backgroundColor;
  final Color? colorFont;
  final RoundedRectangleBorder? shape;
  final double? fontSize;
  final bool personalizedBorder;
  final Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: showButton ? onPressed : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: personalizedBorder
                    ? BorderSide(
                        color: colorBorder ??
                            const Color(0x00000000), // Cor da borda
                        width: 1.5)
                    : BorderSide.none),
            minimumSize: Size(width ?? double.infinity, heigth ?? 50.0)),
        child: BaseText(
            text: text,
            alignText: true,
            size: fontSize ?? 12,
            color: colorFont!));
  }
}
