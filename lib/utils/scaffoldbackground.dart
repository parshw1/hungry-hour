import 'package:flutter/material.dart';

class Scaffoldbackground extends StatelessWidget {
  final Widget widget;
  const Scaffoldbackground({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Colors.orangeAccent,
          ],
        ),
      ),
      child: widget,
    );
  }
}
