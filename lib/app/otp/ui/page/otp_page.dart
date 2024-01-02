import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/otp/ui/bloc/auth_bloc.dart';
import 'package:simulados_anac/app/punctuation/ui/widgets/custm_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late IAuthBloc authBloc;
  final PageController pageController = PageController();
  int currentIndex = 0;
  double opacity = 1;
  Timer? _timer;

  final List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/anac-eb542.appspot.com/o/image8.jpeg?alt=media&token=f6b4bddd-34ae-4f57-8726-9e6f86cc2862',
    'https://firebasestorage.googleapis.com/v0/b/anac-eb542.appspot.com/o/image7.jpeg?alt=media&token=22456ed3-24d9-46e5-af92-846909d90d0d',
    'https://firebasestorage.googleapis.com/v0/b/anac-eb542.appspot.com/o/image6.jpeg?alt=media&token=88324b1f-06c7-4a9e-9088-311e4246b919',
    'https://firebasestorage.googleapis.com/v0/b/anac-eb542.appspot.com/o/image5.jpeg?alt=media&token=93523741-aad9-4d27-8329-72cc0cc7390b',
  ];

  @override
  void initState() {
    super.initState();
    authBloc = Modular.get<IAuthBloc>();
    _timer = Timer.periodic(
      const Duration(seconds: 6),
      (timer) async {
        if (mounted) {
          setState(() {
            opacity = 0;
          });

          await pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );

          if (pageController.page != null) {
            setState(() {
              currentIndex = pageController.page!.round() % images.length;
              opacity = 1;
            });
          }
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final image = images[index % images.length];
              return Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  'Bem Vindo',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 274,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      type: ButtonType.google,
                      onTap: () {
                        authBloc.loginGoogle();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      type: ButtonType.facebook,
                      onTap: () {
                        authBloc.loginFacebook();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
