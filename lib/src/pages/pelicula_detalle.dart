import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_provider.dart';
import 'package:movie_app/src/widgets/actor_horizontal.dart';

class PeliculaDetalle extends StatelessWidget {
  final PeliculasProvider _peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    _peliculasProvider.getCast(pelicula.id);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _crearAppbar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _crearCasting(pelicula, context),
          ]),
        ),
      ],
    ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(pelicula.title,
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(pelicula.getBackgroundImg()),
            fadeInDuration: Duration(milliseconds: 300),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          Text(
            pelicula.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  _crearCasting(Pelicula pelicula, BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Actores',
                  style: Theme.of(context).textTheme.headline6)),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: _peliculasProvider.actoresStream,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ActorHorizontal(actores: snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
