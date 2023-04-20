import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/screens/movie_detail.dart';
import 'package:flutter_application_1/widgets/item_popular.dart';

class ListFavorites extends StatefulWidget {
  const ListFavorites({super.key});

  @override
  State<ListFavorites> createState() => _ListFavoritesState();
}

class _ListFavoritesState extends State<ListFavorites> {
  DatabaseHelper? database;

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Favorites'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: database!.GETALLpopular(),
              builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding: EdgeInsets.all(15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .9,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    itemCount:
                        snapshot.data != null ? snapshot.data!.length : 0,
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
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                  label: Text('Favoritos')))
        ],
      ),
    );
  }
}
