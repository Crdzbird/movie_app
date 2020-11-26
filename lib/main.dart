import 'package:flutter/material.dart';
import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'detalle': (context) => PeliculaDetalle(),
      },
    );
  }
}
