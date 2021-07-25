import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> customToast(String message) => Fluttertoast.showToast(
    msg: "$message", backgroundColor: Colors.black, textColor: Colors.white);
