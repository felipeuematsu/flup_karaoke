import 'package:flutter/material.dart';

const buttonStyle = ButtonStyle(
  minimumSize: MaterialStatePropertyAll(Size(0, 42)),
  fixedSize: MaterialStatePropertyAll(null),
  maximumSize: MaterialStatePropertyAll(null),
  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
);

const dialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
);

const cardTheme = CardTheme(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
);
