import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/registrer_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/registrer': (BuildContext context) => RegistrerScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
  };
}
