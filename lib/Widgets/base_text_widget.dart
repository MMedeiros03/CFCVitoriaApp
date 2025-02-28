import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Function? onClick;
  final bool alignText;
  final bool justifyText;
  final bool overflow;
  final bool bold;
  final int? maxLines;

  const BaseText(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      this.bold = true,
      this.alignText = false,
      this.justifyText = false,
      this.overflow = false,
      this.maxLines,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return onClick == null
        ? Text(
            text,
            maxLines: maxLines,
            textAlign: alignText
                ? TextAlign.center
                : justifyText
                    ? TextAlign.justify
                    : TextAlign.start,
            style: TextStyle(
                fontSize: size,
                fontFamily: "Libre Baskerville",
                fontWeight: bold ? FontWeight.bold : FontWeight.w400,
                decoration: TextDecoration.none,
                overflow: overflow ? TextOverflow.ellipsis : null,
                color: color),
          )
        : InkWell(
            onTap: () {
              onClick!();
            },
            child: Text(
              text,
              textAlign: alignText ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  fontSize: size,
                  overflow: overflow ? TextOverflow.ellipsis : null,
                  fontFamily: "Libre Baskerville",
                  fontWeight: bold ? FontWeight.bold : FontWeight.w400,
                  decoration: TextDecoration.none,
                  color: color),
            ),
          );
  }
}
