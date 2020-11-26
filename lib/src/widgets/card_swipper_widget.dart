import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class CardSwipperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwipperWidget({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uid = "${peliculas[index].id}-tarjeta";
          return Hero(
            tag: peliculas[index].uid,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detalle',
                        arguments: peliculas[index]);
                  },
                  child: FadeInImage(
                      placeholder: AssetImage('assets/img/loading.gif'),
                      fit: BoxFit.cover,
                      image: NetworkImage(peliculas[index].getPosterImg())),
                )),
          );
        },
        itemCount: peliculas.length,
      ),
    );
  }
}
