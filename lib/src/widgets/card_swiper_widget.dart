import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> movies;

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
        itemWidth: _screenSize.width * 0.7, // 70%
        itemHeight: _screenSize.height * 0.5, // 50%
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "http://via.placeholder.com/350x150",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
