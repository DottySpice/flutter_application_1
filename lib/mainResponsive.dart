import 'package:flutter/material.dart';

import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/login_screen_desktop.dart';

import 'package:flutter_application_1/responsive/responsive_layout.dart';

class MainResponsive extends StatefulWidget {
  const MainResponsive({super.key});

  @override
  State<MainResponsive> createState() => _MainResponsiveState();
}

class _MainResponsiveState extends State<MainResponsive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          mobileBody: LoginScreen(),
          desktopApp: Row(children: [
            Expanded(child: LoginScreenDesktop()),
          ]),
        ),
      ),
    );
  }
}
