import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/list_post.dart';
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
        title: Text('Bienvenido'),
      ),
      body: ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addPost').then((value) {
            setState(() {});
          });
        },
        label: Text('Add Post'),
        icon: Icon(Icons.add_comment),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(''),
                ),
                accountName: Text('Maximiliano'),
                accountEmail: Text('18031006@itcelaya.edu.mx')),
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/apiMovies');
              },
              title: Text('Popular de API'),
              subtitle: Text("Pantalla para ver las Popular de las APi"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.movie),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/apiNoticias');
              },
              title: Text('Noticia de API'),
              subtitle: Text("Pantalla para ver las Noticas usando una API"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.newspaper),
            ),
          ],
        ),
      ),
    );
  }
}
