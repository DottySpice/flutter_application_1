import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular_model.dart';

class ItemPopular extends StatelessWidget {
  const ItemPopular({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Hero(
        tag: popularModel.id!,
        child: FadeInImage(
            fit: BoxFit.fitHeight,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}')),
      ),
    );
  }
}
