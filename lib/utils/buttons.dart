import 'package:flutter/material.dart';

ElevatedButton customButton({required VoidCallback onPressed, required String text}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(text),
  );
}