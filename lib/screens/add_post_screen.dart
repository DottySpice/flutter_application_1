import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/post_model.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();

  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {
    final txtConPost = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final objPostModel =
          ModalRoute.of(context)!.settings.arguments as PostModel;
      txtConPost.text = objPostModel!.dscPost!;
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          height: 350,
          decoration: BoxDecoration(
              color: Colors.black54, border: Border.all(color: Colors.green)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPostModel == null ? Text('Add Post:') : Text('Update Post: '),
              TextFormField(
                controller: txtConPost,
                maxLines: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPostModel == null) {
                      database.INSERT('tblPost', {
                        'dscPost': txtConPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0
                            ? 'Registro insertado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.UPDATE('tblPost', {
                        'idPost': objPostModel!.idPost,
                        'dscPost': txtConPost.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0
                            ? 'Registro actualizado'
                            : 'Ocurrio un error';

                        var snackBar = SnackBar(content: Text(msg));

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    //flag.setflagListPost();
                  },
                  child: Text('Hola amigos'))
            ],
          ),
        ),
      ),
    );
  }
}
