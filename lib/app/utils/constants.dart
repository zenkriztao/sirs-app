import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimarySecondColor = Color(0xFF282828);

const Color kPrimaryDark100 = Color(0xFF121212);
const Color kPrimaryDark200 = Color(0xFF282828);
const Color kPrimaryDark300 = Color(0xFF3f3f3f);
// const Color kPrimaryblue500 = Color(0xFFa688fa);
const Color kPrimaryblue500 = Color(0xFF6F35A5);
Color colorPrimary = const Color.fromRGBO(100, 181, 246, 1);
const Color colorAccent = Colors.white;
//TODO: Implement Constants
// Color colorPrimaryL = Colors.blue.shade300;
const Color colorBackgroundLL = Color(0xffDEDEDE);
const Color colorPrimaryL = Color(0xff3677FE);
const Color colorPrimaryLL = Color(0xff3677FE);
const Color colorTextSmall = Color(0xff999898);
const Color colorDarkGrey = Color(0xff31363F);

abstract class PageType {
  PageType._();
  static const TAMBAH = 0;
  static const EDIT = 1;
  static const DETAIL = 2;
  static const PIN = 3;
  static const CHANGEPASSWORD = 4;
}

InputDecoration borderTextFormField = InputDecoration(
  hintStyle: GoogleFonts.sora(
    color: colorPrimaryL,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: colorPrimaryL,
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: colorPrimaryL,
      width: 2,
    ),
  ),
  labelStyle: GoogleFonts.sora(
    color: colorPrimaryL,
  ),
);
