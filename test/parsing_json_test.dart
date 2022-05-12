import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';

var testParsing = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};

void main() {
  test("Test Json Parsing", () async {
    var result = Restaurant.fromJson(testParsing).name;

    expect(result, "Kafe Kita");
  });
}
