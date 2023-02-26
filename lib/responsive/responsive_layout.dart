import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopApp;

  ResponsiveLayout({required this.mobileBody, required this.desktopApp});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileBody;
        } else {
          return desktopApp;
        }
      },
    );
  }
}
