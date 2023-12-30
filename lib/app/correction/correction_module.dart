import 'package:flutter_modular/flutter_modular.dart';

import 'ui/page/correction_page.dart';

class CorrectionModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => CorrectionPage(
        question: r.args.data['question'],
        type: r.args.data['type'],
      ),
    );
  }
}
