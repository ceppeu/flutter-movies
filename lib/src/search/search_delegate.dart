import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final movieProvider = new MovieProvider();
  final movies = [
    'Spiderman',
    'XMen',
    'Ironman',
    'Shazam',
    'Matilda',
    'Eraserhead',
    'El señor de los anillos',
    'Capitan America'
  ];
  final recentMovies = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: movie);
              },
            );
          }).toList());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final suggestedList = (query.isEmpty)
  //       ? recentMovies
  //       : movies
  //           .where((element) =>
  //               element.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //   return ListView.builder(
  //     itemCount: suggestedList.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestedList[index]),
  //       );
  //     },
  //   );
  // }
}
