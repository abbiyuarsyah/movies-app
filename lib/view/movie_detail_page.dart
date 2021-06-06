import 'package:flutter/material.dart';
import 'package:movie_db_app/data/model/movie_list_response.dart';

class MovieDetailPage extends StatelessWidget {
  Result? result;

  MovieDetailPage({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(result?.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  result?.title ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                color: Colors.grey.withAlpha(80),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  "Release date",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  result?.releaseDate ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                color: Colors.grey.withAlpha(80),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  result?.overview ?? "-",
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                color: Colors.grey.withAlpha(80),
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "http://image.tmdb.org/t/p/w500/${result?.posterPath}",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
