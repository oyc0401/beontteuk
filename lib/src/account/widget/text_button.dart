import 'package:beontteuk/utils/letter_space_text_style.dart';
import 'package:beontteuk/utils/colorss.dart';
import 'package:flutter/material.dart';


class TextMiniButton extends StatelessWidget {
  const TextMiniButton(
    this.text, {
    Key? key,
    required this.onclick,
    required this.padding,
    this.style,
  }) : super(key: key);
  final VoidCallback onclick;
  final String text;
  final EdgeInsets padding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onclick,
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style: style ??
                const LetterStyle(
                  fontSize: 14,
                  color: Colorss.text2,
                ),
          ),
        ),
      ),
    );
  }
}
