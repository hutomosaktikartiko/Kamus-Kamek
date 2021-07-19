import 'package:flutter/material.dart';

const Color purple = Color(0xFF4545A9);
const Color mainColor = Color(0xFF4766FD);
const Color mainColor2 = Color(0xFF2D4DFE);

// begin -> mainColor, end -> mainColor2
LinearGradient linearGradient(
        {AlignmentGeometry begin = Alignment.centerLeft,
        AlignmentGeometry end = Alignment.centerRight}) =>
    LinearGradient(
      begin: begin, end: end, colors: [mainColor, mainColor2.withOpacity(0.6)]
    );
