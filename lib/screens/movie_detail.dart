import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/actor_model.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();
  DatabaseHelper database = DatabaseHelper();

  final PopularModel modelito;

  MovieDetail({Key? key, required this.modelito}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double rateo = 0;
    if (modelito.voteAverage != null) {
      rateo = modelito.voteAverage!;
    } else {
      rateo = 0; //return value if str is null
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Hero(
            tag: modelito.id!,
            child: Container(
              decoration: new BoxDecoration(
                color: Color.fromARGB(255, 58, 64, 73),
              ),
            ),
          ),
          Positioned(
            top: 150,
            child: Container(
              padding: EdgeInsets.only(top: 70),
              width: queryData.size.width, //parent size
              height: 200, //parent size
              child: LayoutBuilder(builder: (context, size) {
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: new NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/${modelito.posterPath}'))),
                      height: size.maxHeight,
                      width: size.maxHeight,
                    ),
                    Expanded(
                      child: Column(children: [
                        Expanded(
                          child: Container(
                            child: Text(modelito.title.toString(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: RatingBar(
                              initialRating: rateo / 2,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star_rounded,
                                      color: Colors.yellowAccent),
                                  half: const Icon(
                                    Icons.star_border_purple500_rounded,
                                    color: Colors.yellowAccent,
                                  ),
                                  empty: const Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.yellowAccent,
                                  )),
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                                child: Text(modelito.overview.toString())),
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              }),
            ),
          ),
          Positioned(
              top: 200,
              child: Container(
                height: 250,
                width: queryData.size.width,
                color: Colors.indigoAccent,
                child: FutureBuilder(
                    future: apiPopular.getVideo(modelito.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return YoutubePlayer(
                          controller: YoutubePlayerController(
                              initialVideoId: snapshot.data.toString(),
                              flags: YoutubePlayerFlags(
                                autoPlay: true,
                                mute: false,
                                controlsVisibleAtStart: false,
                              )),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )),
          Positioned(
            top: 500,
            child: Container(
              height: 150,
              width: queryData.size.width,
              //color: Colors.purple,
              child: FutureBuilder<List<ActorModel>?>(
                  future: apiPopular.getAllActors(modelito),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            ActorModel actor = snapshot.data![index];
                            return CartaActor(
                              actor.name.toString(),
                              actor.profilePath != null
                                  ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                  : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                              actor.character!,
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
          Positioned(
              child: FutureBuilder(
                  future: database.GETONEpopular(modelito.id!),
                  builder: (context, snapshot) {
                    if (snapshot.data != true) {
                      return FloatingActionButton(
                          child: Icon(Icons.favorite_border),
                          onPressed: () {
                            database
                                .INSERT('tblPopularFavorito', modelito.toMap())
                                .then((value) {
                              flag.setFlagListPost();
                              var msj = value > 0
                                  ? 'Se agrego a favoritos'
                                  : 'ocurrio un error';

                              var snackBar = SnackBar(content: Text(msj));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          });
                    } else {
                      return FloatingActionButton(
                          child: Icon(Icons.favorite),
                          onPressed: () {
                            database.DELETEpopular(
                                    'tblPopularFavorito', modelito.id!)
                                .then((value) {
                              flag.setFlagListPost();
                              var msj = value > 0
                                  ? 'Se eliminó correctamente'
                                  : 'ocurrio un error';

                              var snackBar = SnackBar(content: Text(msj));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          });
                    }
                  })),
        ],
      ),
    );
  }

  Widget CartaActor(
      final String name, final String photoUrl, final String character) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              photoUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'As: $character',
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 208, 195)),
          ),
        ],
      ),
    );
  }
}
