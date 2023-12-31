import 'package:flutter_modular/flutter_modular.dart';

import 'ui/page/otp_page.dart';

class OtpModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const OtpPage());
  }
}
