import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            print('click');
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            progress: transitionAnimation, icon: AnimatedIcons.menu_arrow),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((e) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(e.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(e.title),
                subtitle: Text(e.originalTitle),
                onTap: () {
                  close(context, null);
                  e.uid = '';
                  Navigator.pushNamed(context, 'detalle', arguments: e);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
