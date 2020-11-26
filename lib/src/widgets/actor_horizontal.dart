import 'package:flutter/material.dart';
import 'package:movie_app/src/models/actores_model.dart';

class ActorHorizontal extends StatelessWidget {
  final List<Actor> actores;

  ActorHorizontal({@required this.actores});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.22,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: actores.length,
        itemBuilder: (context, index) {
          return _tarjeta(context, actores[index]);
        },
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Actor e) {
    final actorTarjeta = Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'),
              image: NetworkImage(e.getFoto()),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            e.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    return actorTarjeta;
  }
}
