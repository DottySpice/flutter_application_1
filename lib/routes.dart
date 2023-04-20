import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_post_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/list_popular_videos.dart';
import 'package:flutter_application_1/screens/registrer_screen.dart';
import 'package:flutter_application_1/screens/temas_preferencia.dart';
import 'package:flutter_application_1/screens/list_noticias.dart';
import 'package:flutter_application_1/screens/list_favorites.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/registrer': (BuildContext context) => RegistrerScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/temas': (BuildContext context) => TemasPage(),
    '/addPost': (BuildContext context) => AddPostScreen(),
    '/apiMovies': (BuildContext context) => ListPopularVideos(),
    '/apiNoticias': (BuildContext context) => ListNoticias(),
    '/apiMoviesFav': (BuildContext context) => ListFavorites(),
  };
}
