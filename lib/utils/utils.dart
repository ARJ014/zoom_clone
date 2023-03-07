import 'package:flutter/material.dart';

showSnackBar(context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
