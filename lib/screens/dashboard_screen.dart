import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/settings/styles.settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('AMLO'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE3nNWAJxusRTcwpB1hL2MwlgczPjIxIrelFNEGvANzZuiddRUjqb5YoDC6qR7bPQmHSY&usqp=CAU'),
                ),
                accountName: Text('LA MERA VERGA'),
                accountEmail: Text('APOCO SI BIEN VERGA')),
            ListTile(
              onTap: () {},
              title: Text('Practica 1'),
              subtitle: Text("Descripcion de la practica"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/temas');
              },
              title: Text('Preferencias Temas'),
              subtitle: Text("Selecciona la preferencia de tu tema"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            DayNightSwitcher(
                isDarkModeEnabled: isDarkModeEnabled,
                onStateChanged: (isDarkModeEnabled) {
                  isDarkModeEnabled ? theme.currentTheme : theme.currentTheme;
                  this.isDarkModeEnabled = isDarkModeEnabled;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
