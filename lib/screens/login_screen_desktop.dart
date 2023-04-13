import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../widgets/loading_modal_widget.dart';

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({super.key});

  @override
  State<LoginScreenDesktop> createState() => _LoginScreenState();
}

bool isLoading = false;

final widthSize = 500.00;

final txtEmail = SizedBox(
  width: widthSize,
  child: TextFormField(
    decoration: InputDecoration(
      label: Text('Email User'),
      border: OutlineInputBorder(),
    ),
  ),
);

final txtPass = SizedBox(
  width: widthSize,
  child: TextFormField(
    decoration: InputDecoration(
      label: Text('Password User'),
      border: OutlineInputBorder(),
    ),
  ),
);

final btnGoogle = SocialLoginButton(
  buttonType: SocialLoginButtonType.google,
  width: widthSize,
  onPressed: () {},
);

final btnFacebook = SocialLoginButton(
  buttonType: SocialLoginButtonType.facebook,
  width: widthSize,
  onPressed: () {},
);

final btnGithub = SocialLoginButton(
  buttonType: SocialLoginButtonType.github,
  width: widthSize,
  onPressed: () {},
);

final spaceHorizontal = SizedBox(height: 20);

final imgLogo = Image.asset(
  'assets/logo.png',
  height: 70,
);

final imgFondo = AssetImage('assets/fondo.jpg');

class _LoginScreenState extends State<LoginScreenDesktop> {
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
                TextStyle(fontSize: 10, decoration: TextDecoration.underline)),
      ),
    );

    final btnEmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      width: widthSize,
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

    final responsiveActual = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: .6, fit: BoxFit.cover, image: imgFondo)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: imgLogo),
                      spaceHorizontal,
                      Text(responsiveActual.toString()),
                      Expanded(child: txtEmail),
                      spaceHorizontal,
                      Expanded(child: txtPass),
                      spaceHorizontal,
                      Expanded(child: btnEmail),
                      spaceHorizontal,
                      Expanded(child: btnGoogle),
                      spaceHorizontal,
                      Expanded(child: btnFacebook),
                      spaceHorizontal,
                      Expanded(child: txtRegistrer),
                    ],
                  ),
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
