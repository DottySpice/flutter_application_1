import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/loading_modal_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isLoading = false;

String userName = "";
String profilePicture = "";
String userEmail = "";
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

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

final btnFacebook = SocialLoginButton(
  buttonType: SocialLoginButtonType.facebook,
  onPressed: () {},
);

final spaceHorizontal = SizedBox(height: 10);

final imgLogo = Image.asset(
  'assets/logo.png',
  height: 60,
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

    Future<Map<String, dynamic>> signInWithGitHub() async {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();

      final UserCredential =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);

      final User user = FirebaseAuth.instance.currentUser!;

      final Map<String, dynamic> userInfo = {
        'userName': user.displayName!,
        'profilePicture': user.photoURL!,
        'userEmail': ""
      };

      return userInfo;
    }

    final btnGithub = SocialLoginButton(
      buttonType: SocialLoginButtonType.github,
      onPressed: () async {
        final Map<String, dynamic> userInfo = await signInWithGitHub();

        Navigator.pushNamed(context, '/dash', arguments: userInfo);
        signInWithGitHub();
      },
    );

    Future<Map<String, dynamic>> signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("Inicio de sesión exitoso con Google y Firebase");

      final Map<String, dynamic> userInfo = {
        'userName': userCredential.user!.displayName!,
        'profilePicture': userCredential.user!.photoURL!,
        'userEmail': userCredential.user!.email!,
      };

      return userInfo;
    }

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () async {
        final Map<String, dynamic> userInfo = await signInWithGoogle();

        Navigator.pushNamed(context, '/dash', arguments: userInfo);
      },
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      imgLogo,
                      spaceHorizontal,
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnEmail,
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnGithub,
                      spaceHorizontal,
                      txtRegistrer,
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container(),
        ],
      ),
    );
  }
}
