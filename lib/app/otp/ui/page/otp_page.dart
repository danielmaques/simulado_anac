import 'dart:async';

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
  final PageController codeController = PageController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final canSend = ValueNotifier<bool>(false);
  int currentIndex = 0;
  double opacity = 1;

  final List<String> images = [
    'assets/images/image5.jpeg',
    'assets/images/image6.jpeg',
    'assets/images/image7.jpeg',
    'assets/images/image8.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    authBloc = Modular.get<IAuthBloc>();
    Timer.periodic(
      const Duration(seconds: 6),
      (timer) async {
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
      },
    );
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
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.colorBurn,
                    ),
                    image: AssetImage(image),
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
                        codeController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      type: ButtonType.facebook,
                      onTap: () {
                        authBloc.loginFacebook();
                        codeController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
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

  void _validateOtp() {
    if (otpController.text.length == 4) {
      canSend.value = true;
    } else {
      canSend.value = false;
    }
  }
}
