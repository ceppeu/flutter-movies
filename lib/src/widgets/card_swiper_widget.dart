import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      // Usa todo el ancho posible
      // width: double.infinity,
      child: Swiper(
        // Saca los porcentajes de la pantalla
        itemWidth: _screenSize.width * 0.6, // 70%
        itemHeight: _screenSize.height * 0.55, // 50%
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-tarjeta';
          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detalle',
                        arguments: movies[index]);
                  },
                  child: FadeInImage(
                      image: NetworkImage(movies[index].getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      fit: BoxFit.cover),
                )),
          );
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
