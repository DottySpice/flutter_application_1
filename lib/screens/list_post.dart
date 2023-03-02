import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';

import '../models/post_model.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  DatabaseHelper? database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return Container();
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Ocurrio un error"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
