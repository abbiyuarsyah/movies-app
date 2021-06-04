import 'package:flutter/material.dart';
import 'package:movie_db_app/store/movie_list_store.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListStore? _movieListStore;

  @override
  void initState() {
    _movieListStore ??= MovieListStore();
    _movieListStore?.fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
