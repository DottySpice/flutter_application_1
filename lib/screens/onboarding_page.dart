import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/mainResponsive.dart';
import 'package:lottie/lottie.dart';

import '../widgets/card_planet.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "TECNMX Celaya",
      subtitle:
          "El Tecnológico Nacional de México en Celaya fue fundado en 1958 como un centro de segunda enseñanza, capacitación técnica para trabajadores y preparatoria técnica especializada",
      image: const AssetImage("assets/images/img-1.png"),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background:
          Center(child: LottieBuilder.asset("assets/animation/bg-1.json")),
    ),
    CardPlanetData(
      title: "Ingeniería en Sistemas Computacionales",
      subtitle:
          "El y la Ingeniero/a en Sistemas Computacionales, tiene conocimientos de alto nivel tecnológico y científico para ser un profesionista con visión innovadora capaz de crear y proveer soluciones de software e infraestructura computacional de vanguardia en la nueva y dinámica sociedad dela era digital.",
      image: const AssetImage("assets/images/img-2.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background:
          Center(child: LottieBuilder.asset("assets/animation/bg-2.json")),
    ),
    CardPlanetData(
      title: "Misión",
      subtitle:
          "Contribuir a la transformación de la sociedad a través de la formación de ciudadanas y ciudadanos libres y responsables, con sentido de la iniciativa, el respeto, la equidad, la cooperación, la actitud creativa y emprendedora, orientados a la investigación e innovación.",
      image: const AssetImage(
        "assets/images/img-3.png",
      ),
      backgroundColor: Color.fromARGB(255, 42, 5, 187),
      titleColor: Color.fromARGB(255, 0, 243, 252),
      subtitleColor: Colors.white,
      background:
          Center(child: LottieBuilder.asset("assets/animation/bg-3.json")),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainResponsive()),
          );
        },
      ),
    );
  }
}
