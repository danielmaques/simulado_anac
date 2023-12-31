import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ButtonType {
  none,
  google,
  facebook,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.label,
    required this.onTap,
    this.lock = false,
    this.type = ButtonType.none,
  });

  final String? label;
  final bool lock;
  final Function() onTap;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: lock == true ? null : onTap,
          child: Ink(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: type == ButtonType.none
                    ? lock == true
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Theme.of(context).primaryColor
                    : type == ButtonType.google
                        ? Colors.white
                        : const Color(0xFF365899),
              ),
              child: type == ButtonType.none
                  ? Center(
                      child: Text(
                        label!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    )
                  : type == ButtonType.google
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/google.svg'),
                            const SizedBox(width: 15),
                            Text(
                              'Continue with Google',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child:
                                  SvgPicture.asset('assets/icons/facebook.svg'),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'Continue with Facebook',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )),
        ),
      ),
    );
  }
}
