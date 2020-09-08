import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';

import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  MovieProvider movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    movieProvider.getPopularMovies();
    // return Scaffold(body: SafeArea(child: Text('Hola')));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
        future: movieProvider.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(movies: snapshot.data);
          }
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: movieProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData)
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: movieProvider.getPopularMovies,
                );
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
