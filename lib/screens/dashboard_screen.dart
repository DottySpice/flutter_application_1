import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/list_post.dart';
import 'package:flutter_application_1/settings/styles.settings.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isDarkModeEnabled = false;

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print("Sesión cerrada con Google y Firebase");
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    final Map<String, dynamic> userInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String userName = userInfo['userName'];
    final String profilePicture = userInfo['profilePicture'];
    final String userEmail = userInfo['userEmail'];

// Acceda aquí a cualquier otra información del usuario que se haya pasado
    print(userName);
    print(profilePicture);
    print(userEmail);

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
                  backgroundImage: NetworkImage(profilePicture),
                ),
                accountName: Text(userName),
                accountEmail: Text(userEmail)),
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/favFirebase');
              },
              title: Text('Favoritos usando firebase'),
              subtitle: Text("Pantalla para ver favoritos usando firebase"),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.favorite),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              title: Text('Mapa'),
              subtitle: Text("Pantalla para ver el mapa de Google "),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.favorite),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () async {
                await _googleSignIn.signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
