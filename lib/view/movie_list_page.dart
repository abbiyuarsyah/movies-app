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
  TextEditingController _textSearchController = TextEditingController();
  String _query = "Superman";
  bool _isGridView = false;

  @override
  void initState() {
    _movieListStore ??= MovieListStore();
    _movieListStore?.fetchMovieList(_query, "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: (!_isGridView) ? Icon(Icons.grid_view) : Icon(Icons.list),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _searchField(),
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
                      return (_isGridView)
                          ? _gridView(
                              _movieListStore?.movieListResponse?.results ?? [])
                          : _moviesView(
                              _movieListStore?.movieListResponse?.results ??
                                  []);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moviesView(List<Result> results) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
                margin:
                    EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (results[i].posterPath != null)
                        ? Container(
                            width: 92,
                            margin:
                                EdgeInsets.only(top: 16, left: 16, bottom: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w92/${results[i].posterPath}",
                              ),
                            ),
                          )
                        : Container(
                            margin:
                                EdgeInsets.only(top: 16, left: 16, bottom: 16),
                            width: 92,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(50),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                results[i].title ?? "-",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Release date - ${results[i].releaseDate ?? "-"}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withAlpha(150),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "${results[i].overview ?? "-"}",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withAlpha(150),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _gridView(List<Result> results) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 1.4 + 16;
    final double itemWidth = size.width / 2;

    return Container(
      margin: EdgeInsets.only(left: 24, right: 24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: itemWidth / itemHeight),
        shrinkWrap: true,
        itemBuilder: (_, index) => Container(
          margin: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
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
          child: Column(
            children: [
              Container(
                child: (results[index].posterPath != null)
                    ? Container(
                        width: 185,
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w185/${results[index].posterPath}",
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                        width: 185,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  results[index].title ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  results[index].releaseDate ?? "-",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
                child: Text(
                  "${results[index].overview ?? "-"}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
            ],
          ),
        ),
        itemCount: results.length,
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: EdgeInsets.all(24),
      child: TextField(
        controller: _textSearchController,
        style: TextStyle(),
        decoration: InputDecoration(
          hintText: "Search your movie",
          suffixIcon: IconButton(
            onPressed: () {
              _query = _textSearchController.text;
              _movieListStore?.fetchMovieList(_query, "1");
            },
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
