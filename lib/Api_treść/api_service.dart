import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get('https://pollub.pl/rekrutacja/kandydaci/studia-i-stopnia/kierunki-ksztalcenia' as Uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
