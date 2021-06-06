import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_db_app/data/constant/store_state.dart';
import 'package:movie_db_app/data/material/bottom_sheet.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';
import 'package:movie_db_app/store/movie_list_store.dart';
import 'package:movie_db_app/view/movie_detail_page.dart';

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
  bool _isLoading = false;
  int _pageIndex = 1;
  ScrollController _scrollController = ScrollController();
  List<ReactionDisposer>? _disposers;
  double _offset = 0;
  int _currentPage = 0;

  @override
  void initState() {
    _movieListStore ??= MovieListStore();
    _movieListStore?.fetchMovieList(_query, "1");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _disposers ??= [
      reaction((_) => _movieListStore?.lisResult, (results) {
        _isLoading = false;
        setState(() {});
      }),
      autorun((_) => {
            if (_movieListStore?.errorMessage != null)
              {
                showModalBottomSheet(
                  enableDrag: false,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => BottomSheetMaterial().bottomSheetDialog(
                      _movieListStore?.errorMessage?.toString() ?? "", context,
                      () {
                    Navigator.pop(context);
                  }),
                )
              }
          }),
    ];

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
                      _scrollController =
                          ScrollController(initialScrollOffset: _offset);
                      return (_movieListStore?.lisResult.length == 0)
                          ? Center(child: CircularProgressIndicator())
                          : Stack(
                              children: [
                                (_isGridView)
                                    ? _gridView(
                                        _movieListStore?.lisResult ?? [],
                                        _scrollController)
                                    : _moviesView(
                                        _movieListStore?.lisResult ?? [],
                                        _scrollController),
                                (_isLoading)
                                    ? Positioned(
                                        bottom: 0,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            );

                    case StoreState.loaded:
                      _scrollController =
                          ScrollController(initialScrollOffset: _offset);
                      _currentPage =
                          _movieListStore?.movieListResponse?.totalPages ?? 0;
                      _isLoading = false;
                      return (_isGridView)
                          ? _gridView(_movieListStore?.lisResult ?? [],
                              _scrollController)
                          : _moviesView(_movieListStore?.lisResult ?? [],
                              _scrollController);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moviesView(List<Result> results, ScrollController controller) {
    _scrollListener();

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ListView.builder(
          controller: controller,
          itemCount: results.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    result: results[i],
                  ),
                ),
              ),
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

  Widget _gridView(List<Result> results, ScrollController controller) {
    _scrollListener();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 1.4 + 16;
    final double itemWidth = size.width / 2;

    return Container(
      margin: EdgeInsets.only(left: 24, right: 24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: itemWidth / itemHeight),
        shrinkWrap: true,
        controller: controller,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(
                result: results[index],
              ),
            ),
          ),
          child: Container(
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
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          margin: EdgeInsets.only(bottom: 16),
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
                          margin: EdgeInsets.only(bottom: 16),
                          width: 185,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(50),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
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
                  margin:
                      EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
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
          focusColor: Colors.green,
          hintText: "Search your movie",
          suffixIcon: IconButton(
            onPressed: () {
              _offset = 0;
              _pageIndex = 1;
              _movieListStore?.reset();
              _query = _textSearchController.text;
              _movieListStore?.fetchMovieList(_query, "1");
            },
            icon: Icon(
              Icons.search,
              color: Colors.green,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  _scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!_isLoading && _currentPage != _pageIndex) {
          _offset = _scrollController.offset;
          _isLoading = true;
          _pageIndex = _pageIndex + 1;
          _movieListStore?.fetchMovieList(_query, _pageIndex.toString());
        }
      }
    });
  }
}
