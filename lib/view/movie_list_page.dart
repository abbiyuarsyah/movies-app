import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_db_app/data/constant/store_state.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';
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
    _movieListStore?.fetchMovieList("superman", "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Observer(builder: (_) {
                  switch (_movieListStore!.updateState) {
                    case StoreState.initial:
                      return Container();
                    case StoreState.loading:
                      return Center(child: CircularProgressIndicator());
                    case StoreState.loaded:
                      return _moviesView(
                          _movieListStore?.movieListResponse?.results ?? []);
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _moviesView(List<Result> results) {
    return Container(
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ]),
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                        child: Image.network(
                          "http://image.tmdb.org/t/p/w92/${results[i].posterPath}",
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.all(16),
                          child: Flexible(
                            child: Text(
                              results[i].title ?? "-",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
