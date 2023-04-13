import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class RegistrerScreen extends StatefulWidget {
  const RegistrerScreen({super.key});

  @override
  State<RegistrerScreen> createState() => _RegistrerScreenState();
}

final TextEditingController controller = new TextEditingController();
final GlobalKey<FlutterPwValidatorState> validatorKey =
    GlobalKey<FlutterPwValidatorState>();

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
    final bool isEmailValidate = EmailValidator.validate(value as String);
    if (!isEmailValidate || value!.isEmpty) {
      return 'Ingrese un correo electronico valido';
    }
    return null;
  },
);

final imgLogo = Image.asset(
  'assets/logo.png',
  height: 70,
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

final spaceHorizontal = SizedBox(height: 10);

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

  Future getImageCamara() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporaly = File(image.path);

    setState(() {
      this._image = imageTemporaly;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool validatePassword = false;

    final txtPassValidate = FlutterPwValidator(
        key: validatorKey,
        specialCharCount: 1,
        width: 500,
        height: 100,
        minLength: 8,
        onSuccess: () {
          validatePassword = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Contrasena valida")));
        },
        controller: controller);

    final txtPass = TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text('Password User'),
          border: OutlineInputBorder(borderSide: BorderSide()),
        ),
        validator: (value) {
          if (!validatePassword) {
            return 'Ingrese una contrasena correcta';
          }
          return null;
        });

    final btnAvatar = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      backgroundColor: Colors.blue,
      text: 'Añadir foto de galeria',
      onPressed: getImage,
    );

    final btnAvatarCamara = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      backgroundColor: Colors.blue,
      text: 'Añadir foto de camara',
      onPressed: getImageCamara,
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
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    txtRegistro,
                    spaceHorizontal,
                    imgAvatar,
                    spaceHorizontal,
                    btnAvatar,
                    spaceHorizontal,
                    btnAvatarCamara,
                    spaceHorizontal,
                    txtUser,
                    spaceHorizontal,
                    txtEmail,
                    spaceHorizontal,
                    txtPass,
                    spaceHorizontal,
                    txtPassValidate,
                    spaceHorizontal,
                    btnRegister,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
