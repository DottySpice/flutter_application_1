import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../widgets/item_post_widget.dart';

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
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    flag.getFlagListPost();

    return FutureBuilder(
      future: flag.getFlagListPost() == true
          ? database!.GETALLPOST()
          : database!.GETALLPOST(),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostWidget(objPostModel: objPostModel);
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
