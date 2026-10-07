import 'package:test/test.dart';

void main() {
  test(
    "test split",
    () {
      String execDecode(String code, String type) {
        var decoded = '';
        final splitSize = 4;
        RegExp exp = new RegExp(r"\d{" + "$splitSize" + "}");
        Iterable<Match> matches = exp.allMatches(code);
        List<String> sps = [];
        matches.forEach((element) {
          print(element.group(0));
          sps.add(element.group(0).toString());
        });
        print("myD :$sps");

        var chars = {
          "6062": "0",
          "8439": "1",
          "9311": "2",
          "5685": "3",
          "8184": "4",
          "6670": "5",
          "9362": "6",
          "7585": "7",
          "1186": "8",
          "2587": "9",
          "6527": "a",
          "3620": "b",
          "2068": "c",
          "3282": "d",
          "9588": "e",
          "5628": "f",
          "1684": "g",
          "1256": "h",
          "6315": "i",
          "8328": "j",
          "1803": "k",
          "6757": "l",
          "3517": "m",
          "4178": "n",
          "1643": "o",
          "6793": "p",
          "7028": "q",
          "3805": "r",
          "9037": "s",
          "1744": "t",
          "4087": "u",
          "8558": "v",
          "3514": "w",
          "7418": "x",
          "9640": "y",
          "7215": "z",
          "3196": "A",
          "4495": "B",
          "7492": "C",
          "7588": "D",
          "8143": "E",
          "9643": "F",
          "1325": "G",
          "2526": "H",
          "2644": "I",
          "7343": "J",
          "4906": "K",
          "6111": "L",
          "8650": "M",
          "7736": "N",
          "5335": "O",
          "1806": "P",
          "8757": "Q",
          "6120": "R",
          "9962": "S",
          "3935": "T",
          "6140": "U",
          "8754": "V",
          "4545": "W",
          "6481": "X",
          "7552": "Y",
          "9888": "Z",
          "2342": "-",
          "7027": "_",
          "6422": "/",
          "7783": "?",
          "3795": "=",
          "8579": ".",
          "2466": ":",
        };
        List<String?> decodedList = [];
        for (var char in sps) {
          decodedList.add(chars[char]);
        }
        print('decodedList: $decodedList');
        decoded = decodedList.join();
        print('decoded: $decoded');

        switch (type) {
          case 'video':
            print('https://bayzin.com/uploads/videos/$decoded');
            return 'https://bayzin.com/uploads/videos/$decoded';
            break;
          case 'course':
            print('https://bayzin.com/uploads/courseware/$decoded');
            return 'https://bayzin.com/uploads/courseware/$decoded';
            break;
        }

        return '';
      }

      execDecode("01020315220044", "course");
    },
  );
}
