import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(4, 6),
                              blurRadius: 10),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(colors: <Color>[
                          Colors.deepPurpleAccent,
                          Color.fromARGB(255, 58, 7, 179),
                        ])),
                    height: 150,
                    padding: const EdgeInsets.only(top: 15),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person_rounded,
                              size: 80,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text('Fabian Arancibia'),
                            const Spacer(),
                            RawMaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'home');
                                },
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15.0),
                                child: const FaIcon(
                                    FontAwesomeIcons.rightFromBracket,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 130,
                      left: 50,
                      child: Container(
                        height: 100,
                        width: 250,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(4, 6),
                                  blurRadius: 10),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 58, 7, 179),
                              Colors.deepPurpleAccent.shade700,
                            ])),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cartera Total: \$213.123.123',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Disponible mes: \$213.123.123',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Gasto: \$213.123.123',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const Text('Menú'),
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      ContainerCard(
                          icon: Icons.monetization_on_sharp,
                          router: 'financial-sumary',
                          text: 'Resumen'),
                      ContainerCard(
                          icon: Icons.add_chart,
                          router: 'form-mevement',
                          text: 'Nuevo Movimiento'),
                    ],
                  ),
                  Row(
                    children: [
                      ContainerCard(
                          icon: Icons.bar_chart_sharp,
                          router: 'graphics',
                          text: 'Graficos'),
                      ContainerCard(icon: Icons.abc, router: '', text: ''),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContainerCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final String router;
  const ContainerCard(
      {Key? key, required this.text, required this.icon, required this.router})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: <Color>[
            Colors.deepPurpleAccent,
            Color.fromARGB(255, 58, 7, 179)
          ])),
      height: 100,
      width: 150,
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, router);
        },
        child: Column(
          children: [
            Icon(icon, color: Colors.amber, size: 30),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
