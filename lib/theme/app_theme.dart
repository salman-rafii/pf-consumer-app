import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pf_consumer_app/utils/dimensions.dart';
import 'package:pf_consumer_app/views/widgets/app_text.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    textTheme: GoogleFonts.workSansTextTheme(const TextTheme()),
    primaryColor: const Color(0xffE73D2A),
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    cardColor: cardBackground,
    colorScheme: ColorScheme.fromSeed(seedColor: red),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: black,
      elevation: 0,
      iconTheme: IconThemeData(color: black, size: 30),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: black,
        fontSize: 16,
      ),
    ),
    typography: Typography.material2021(),
  );

  static const Color red = Color(0xffE73D2A);
  static const Color white = Colors.white;
  static const Color black = Color(0xff120402);
  static const Color cardBackground = Color(0xffFFFAFA);

  static const Color ash = Color(0xffCCCCCC);
  static const Color cement = Color(0xff8B8989);
  static const Color wall = Color(0xffF0F0F0);

  static const Color pastelLight1 = Color(0xffF7BCB6);
  static const Color pastelLight2 = Color(0xffF39E94);
  static const Color pastel = Color(0xffFFFFFF);
  static const Color eggshell = Color(0xffFFFAFA);

  static const Color gray700 = Color(0xff344054);
  static const Color gray300 = Color(0xffD0D5DD);
  static const Color gray100 = Color(0xffF1F5F9);
  static const Color gray400 = Color(0xff94A3B8);

  static const Color green = Color(0xff34D399);
  static const Color yellow = Color(0xffFBBF24);

  static var gradient = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topRight,
    colors: [Color(0xffE73D2A), Color.fromRGBO(231, 61, 42, 0.5)],
  );

  static InputDecoration otherInputDecoration(
    String hint, {
    Color? border,
    Color? fillColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: border ?? AppTheme.ash),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: border ?? AppTheme.ash),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    fillColor: fillColor,
    filled: fillColor != null,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );

  static InputDecoration inputDecoration(
    String hint, {
    Color? border,
    Color? fillColor,
    Color? valueColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? inlineHint,
  }) => InputDecoration(
    prefixIcon: hint == ''
        ? null
        : Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: AppText(
              text: hint,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeDefault,
                color: AppTheme.cement,
              ),
            ),
          ),
    hintText: inlineHint,
    isDense: false,
    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    fillColor: fillColor,
    filled: fillColor != null,
    suffixIcon: suffixIcon,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppTheme.ash),
    ),
  );

  static RoundedRectangleBorder defaultShape({double radius = 0}) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: const BorderSide(color: AppTheme.wall),
      );

  static const textLabel = TextStyle(
    color: AppTheme.cement,
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.fontSizeSmall,
  );
}

// const Color pastelLight1 = Color(0xff120402);
