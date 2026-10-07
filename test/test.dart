import 'package:test/test.dart';

void main() {
  test('test', () {
    expect(1, 1);
  });
}
/*test(
    "test split",
    () {
      final splitSize = 4;
      RegExp exp = new RegExp(r"\d{" + "$splitSize" + "}");
      String str = "0102031522";
      Iterable<Match> matches = exp.allMatches(str);
      var list = matches.map((m) => int.tryParse(m.group(0)));
      print(list);
    },
  );*/



  