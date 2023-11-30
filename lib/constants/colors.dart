import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFEAE2E6),
  100: Color(0xFFC9B8C1),
  200: Color(0xFFA68898),
  300: Color(0xFF82586E),
  400: Color(0xFF67354F),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF450F2B),
  700: Color(0xFF3C0C24),
  800: Color(0xFF330A1E),
  900: Color(0xFF240513),
});
const int _primaryPrimaryValue = 0xFF4C1130;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFF609C),
  200: Color(_primaryAccentValue),
  400: Color(0xFFF9005E),
  700: Color(0xFFE00054),
});
const int _primaryAccentValue = 0xFFFF2D7C;

const MaterialColor containerprimary =
    MaterialColor(_containerprimaryPrimaryValue, <int, Color>{
  50: Color(0xFFF9FCFE),
  100: Color(0xFFF1F6FB),
  200: Color(0xFFE7F1F9),
  300: Color(0xFFDDEBF7),
  400: Color(0xFFD6E6F5),
  500: Color(_containerprimaryPrimaryValue),
  600: Color(0xFFCADFF1),
  700: Color(0xFFC3DAEF),
  800: Color(0xFFBDD6ED),
  900: Color(0xFFB2CFEA),
});
const int _containerprimaryPrimaryValue = 0xFFCFE2F3;

const MaterialColor containerprimaryAccent =
    MaterialColor(_containerprimaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_containerprimaryAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _containerprimaryAccentValue = 0xFFFFFFFF;

const MaterialColor background =
    MaterialColor(_backgroundPrimaryValue, <int, Color>{
  50: Color(0xFFFCF9FB),
  100: Color(0xFFF9F1F5),
  200: Color(0xFFF5E8EE),
  300: Color(0xFFF0DFE7),
  400: Color(0xFFEDD8E1),
  500: Color(_backgroundPrimaryValue),
  600: Color(0xFFE7CCD8),
  700: Color(0xFFE4C6D3),
  800: Color(0xFFE1C0CE),
  900: Color(0xFFDBB5C5),
});
const int _backgroundPrimaryValue = 0xFFEAD1DC;

const MaterialColor backgroundAccent =
    MaterialColor(_backgroundAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_backgroundAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _backgroundAccentValue = 0xFFFFFFFF;
