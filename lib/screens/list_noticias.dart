import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/noticia_model.dart';
import 'package:flutter_application_1/network/api_noticia.dart';
import 'package:flutter_application_1/widgets/item_noticia.dart';

class ListNoticias extends StatefulWidget {
  const ListNoticias({super.key});

  @override
  State<ListNoticias> createState() => _ListNoticiasState();
}

class _ListNoticiasState extends State<ListNoticias> {
  ApiNoticia? apiNoticia;

  void initState() {
    super.initState();
    apiNoticia = ApiNoticia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Noticias'),
      ),
      body: FutureBuilder(
          future: apiNoticia!.getAllNoticia(),
          builder: (context, AsyncSnapshot<List<NoticiaModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  return ItemNoticia(noticiaModel: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrio un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
