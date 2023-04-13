import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/noticia_model.dart';

import '../screens/noticia_detail.dart';

class ItemNoticia extends StatelessWidget {
  const ItemNoticia({super.key, required this.noticiaModel});

  final NoticiaModel noticiaModel;

  @override
  Widget build(BuildContext context) {
    final spaceHorizontal = SizedBox(width: 10);

    final txtAuthor = Text('${noticiaModel.author}');

    final txtTitle = Text('${noticiaModel.title}');

    final imgPost = Image(
      image: NetworkImage('${noticiaModel.urlToImage}'),
      height: 150,
    );

    final txtDesc = Text(
      '${noticiaModel.description}',
      softWrap: false,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );

    return Container(
        child: Card(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: txtTitle,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: txtAuthor,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [imgPost],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: txtDesc,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Ver mas..'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          //Mando el contexto de la noticia actual hacia la pagina de noticia info
                          builder: (BuildContext context) =>
                              NoticiaDetail(noticiaInfo: noticiaModel)));
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }

  //FadeInImage(
  ///      fit: BoxFit.fill,
  //      placeholder: AssetImage('assets/loading.gif'),
  //      image: NetworkImage('${noticiaModel.urlToImage}'))
}
