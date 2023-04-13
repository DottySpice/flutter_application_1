import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/database_helper.dart';
import '../models/noticia_model.dart';
import '../models/popular_model.dart';
import '../network/api_popular.dart';

class NoticiaDetail extends StatelessWidget {
  ApiPopular apiPopular = ApiPopular();
  DatabaseHelper database = DatabaseHelper();

  final NoticiaModel noticiaInfo;

  //Se obtiene el noticiaInfo del parametro enviado
  NoticiaDetail({Key? key, required this.noticiaInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    final spaceHorizontal = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion de noticia'),
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    '${noticiaInfo.title}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Chip(
                        label: Text(
                          'Author: ' + '${noticiaInfo.author}',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Chip(
                        label: Text(
                          'Date: ' + '${noticiaInfo.publishedAt}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 170,
                    image: NetworkImage(
                      '${noticiaInfo.urlToImage}',
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Chip(
                    label: Text(
                      'Descripcion',
                      textAlign: TextAlign.center,
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    '${noticiaInfo.content}',
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Chip(
                    label: Text(
                      'Contenido de la noticia',
                      textAlign: TextAlign.center,
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    '${noticiaInfo.content}',
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Link(
                    uri: Uri.parse('${noticiaInfo.url}'),
                    target: LinkTarget.blank,
                    builder: (BuildContext ctx, FollowLink? openLink) {
                      return TextButton.icon(
                        onPressed: openLink,
                        label: const Text('Link to Noticie'),
                        icon: const Icon(Icons.read_more),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
