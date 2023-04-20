import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';
import 'package:flutter_application_1/screens/movie_detail.dart';
import 'package:flutter_application_1/widgets/item_popular.dart';
import 'package:flutter_application_1/database/database_helper.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPopular;
  DatabaseHelper? database;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Popular'),
      ),
      body: Stack(children: [
        FutureBuilder(
            future: apiPopular!.getAllPopular(),
            builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .9,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                  itemBuilder: (context, index) {
                    PopularModel model = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovieDetail(modelito: model)));
                      },
                      child: ItemPopular(popularModel: snapshot.data![index]),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Tiene error'),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/apiMoviesFav');
              },
              icon: Icon(Icons.favorite),
              label: Text('Favoritos')),
        )
      ]),
    );
  }
}
