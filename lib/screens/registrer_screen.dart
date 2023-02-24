import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistrerScreen extends StatefulWidget {
  const RegistrerScreen({super.key});

  @override
  State<RegistrerScreen> createState() => _RegistrerScreenState();
}

final txtAvatar = TextFormField(
  decoration: InputDecoration(
    label: Text('Avatar del usuario'),
    border: OutlineInputBorder(),
  ),
);

final txtEmail = TextFormField(
  decoration: InputDecoration(
    label: Text('Email User'),
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value!.isEmpty || !value.contains('@')) {
      return 'Ingrese un correo electronico valido';
    }
    return null;
  },
);

final txtPass = TextFormField(
  decoration: InputDecoration(
    label: Text('Password User'),
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value!.isEmpty || value.length < 8) {
      return 'Ingrese una contraseña con mas de 8 digitos';
    }
    return null;
  },
);

final txtUser = TextFormField(
  decoration: InputDecoration(
    label: Text('User name'),
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value!.isEmpty || value.length < 3) {
      return 'Ingrese un nombre de usuario correcto';
    }
    return null;
  },
);

final txtRegistro = Text("Registro", style: TextStyle(fontSize: 25));

final spaceHorizontal = SizedBox(height: 20);

final _formKey = GlobalKey<FormState>();

final imgFondo = AssetImage('assets/fondo.jpg');

class _RegistrerScreenState extends State<RegistrerScreen> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporaly = File(image.path);

    setState(() {
      this._image = imageTemporaly;
    });
  }

  @override
  Widget build(BuildContext context) {
    final btnAvatar = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      backgroundColor: Colors.blue,
      text: 'Añadir foto',
      onPressed: getImage,
    );

    final imgAvatar = _image != null
        ? Image.file(
            _image!,
            height: 90,
          )
        : Image.asset(
            'assets/logo.png',
            height: 90,
          );

    final btnRegister = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Procesando datos')),
          );
        }
      },
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: .6, fit: BoxFit.cover, image: imgFondo)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    spaceHorizontal,
                    spaceHorizontal,
                    spaceHorizontal,
                    txtRegistro,
                    spaceHorizontal,
                    btnAvatar,
                    spaceHorizontal,
                    txtUser,
                    spaceHorizontal,
                    txtEmail,
                    spaceHorizontal,
                    txtPass,
                    spaceHorizontal,
                    btnRegister,
                  ],
                ),
                Positioned(
                  child: imgAvatar,
                  top: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
