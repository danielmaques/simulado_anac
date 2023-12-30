import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/punctuation/ui/page/punctuation_page.dart';

class PunctuationModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => PunctuationPage(
        question:
            r.args.data.containsKey('question') ? r.args.data['question'] : [],
        amount: r.args.data.containsKey('amount') ? r.args.data['amount'] : 0,
      ),
    );
  }
}
