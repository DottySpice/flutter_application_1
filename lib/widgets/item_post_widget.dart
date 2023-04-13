import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.objPostModel});

  PostModel? objPostModel;
  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/logo.png'),
    );

    final txtUser = Text('UN nombre');

    final datePost = Text('06/03/2023');

    final imgPost = Image(
      image: AssetImage('assets/fondo.jpg'),
      height: 30,
    );

    final txtDesc = Text(objPostModel!.dscPost!);

    final iconRate = Icon(Icons.star);
    final spaceHorizontal = SizedBox(width: 10);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              spaceHorizontal,
              txtUser,
              Expanded(child: Container()),
              datePost,
              spaceHorizontal
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [imgPost, spaceHorizontal, txtDesc, spaceHorizontal],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              spaceHorizontal,
              iconRate,
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'addPost',
                        arguments: objPostModel);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmar borrado'),
                        content: const Text('Deseas borrar esta publicacion?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                database
                                    .DELETE('tblPost', objPostModel!.idPost!)
                                    .then((value) => flag.setFlagListPost());
                                Navigator.pop(context);
                              },
                              child: const Text('Si')),
                          TextButton(onPressed: () {}, child: const Text('No'))
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
