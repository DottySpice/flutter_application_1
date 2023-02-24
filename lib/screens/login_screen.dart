import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../widgets/loading_modal_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isLoading = false;

final txtEmail = TextFormField(
  decoration: InputDecoration(
    label: Text('Email User'),
    border: OutlineInputBorder(),
  ),
);

final txtPass = TextFormField(
  decoration: InputDecoration(
    label: Text('Password User'),
    border: OutlineInputBorder(),
  ),
);

final btnGoogle = SocialLoginButton(
  buttonType: SocialLoginButtonType.google,
  onPressed: () {},
);

final btnFacebook = SocialLoginButton(
  buttonType: SocialLoginButtonType.facebook,
  onPressed: () {},
);

final btnGithub = SocialLoginButton(
  buttonType: SocialLoginButtonType.github,
  onPressed: () {},
);

final spaceHorizontal = SizedBox(height: 10);

final imgLogo = Image.asset(
  'assets/logo.png',
  height: 100,
);

final imgFondo = AssetImage('assets/fondo.jpg');

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final txtRegistrer = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registrer');
        },
        child: const Text("Crear cuenta",
            style:
                TextStyle(fontSize: 15, decoration: TextDecoration.underline)),
      ),
    );

    final btnEmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 4000)).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: .6, fit: BoxFit.cover, image: imgFondo)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnEmail,
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      btnGithub,
                      spaceHorizontal,
                      txtRegistrer,
                    ],
                  ),
                  Positioned(
                    child: imgLogo,
                    top: 50,
                  )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container(),
        ],
      ),
    );
  }
}
