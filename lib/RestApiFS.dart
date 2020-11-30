import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

final client = new http.Client();

Future getData(String path) async {
  final data = await client.get(path); // ottengo i dati
  return convert.jsonDecode(data.body)['articles'];
}

Future printData(String path) async {
  final data = await client.get(path);
  print(data.body);
}

class Data {
  int userId;
  int id;
  String title;
  String body;

  Data({this.userId, this.id, this.title, this.body});
}
