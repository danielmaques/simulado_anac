import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask/mask.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
              child: PageView.builder(
                controller: codeController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Celular',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [Mask.phone()],
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).cardColor,
                                  )),
                              hintText: '(12) 3 4567-8901',
                              helperStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey[500]),
                            ),
                            onChanged: (_) {
                              _validateCanSend();
                            },
                          ),
                          const SizedBox(height: 30),
                          ValueListenableBuilder(
                            valueListenable: canSend,
                            builder: (_, __, ___) {
                              return CustomButton(
                                label: 'Enviar Codigo',
                                lock: !canSend.value,
                                onTap: () {
                                  authBloc.verifyPhoneNumber(
                                      '+55${numberController.text}');
                                  codeController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (index == 1) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Codigo',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 66,
                              fieldWidth: 53,
                              activeColor: Colors.grey,
                              inactiveColor: Colors.grey,
                            ),
                            controller: otpController,
                            keyboardType: TextInputType.name,
                            onCompleted: (value) {
                              _validateOtp();
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            label: 'Entrar',
                            onTap: () {
                              Modular.to.pushNamed('/home/');
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateCanSend() {
    if (numberController.text.length == 16) {
      canSend.value = true;
    } else {
      canSend.value = false;
    }
  }

  void _validateOtp() {
    if (otpController.text.length == 4) {
      canSend.value = true;
    } else {
      canSend.value = false;
    }
  }
}
