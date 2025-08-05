// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatefulWidget {
  final text,
      fontWeight,
      color,
      overflow,
      textAlign,
      maxLines,
      letterSpacing,
      decoration,
      shadows,
      decorationColor,
      softWrap;
  final bool isPoppin;
  final double? fontSize;
  final double? lineHeight;
  final TextStyle? style;
  const AppText({
    this.text,
    this.letterSpacing,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.overflow,
    this.decoration,
    this.isPoppin = true,
    this.textAlign,
    this.maxLines,
    this.shadows,
    this.decorationColor,
    this.softWrap,
    this.lineHeight,
    key,
    this.style,
  }) : super(key: key);

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return
    // text: widget.text,
    Text(
      widget.text,
      style:
          widget.style ??
          GoogleFonts.poppins(
            // fontFamily: "Poppins",
            letterSpacing: widget.letterSpacing,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
            color: widget.color ?? Colors.black,
            decoration: widget.decoration,
            shadows: widget.shadows,
            height: widget.lineHeight,

            decorationColor: widget.decorationColor,
          ),
      softWrap: widget.softWrap,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}
