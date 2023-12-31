import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mask/mask.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simulados_anac/app/punctuation/ui/widgets/custm_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final PageController pageController = PageController();
  final PageController codeController = PageController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  int currentIndex = 0;
  double opacity = 1;

  final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  @override
  void initState() {
    super.initState();

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
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey[500]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: '(12) 34567-8901',
                              helperStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey[500]),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            label: 'Enviar Codigo',
                            onTap: () {
                              codeController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn,
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
                            length: 4,
                            obscureText: false,
                            textStyle: const TextStyle(color: Colors.grey),
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
                            onCompleted: (value) {},
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            label: 'Entrar',
                            onTap: () {},
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
}
