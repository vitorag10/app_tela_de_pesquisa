import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/operadora.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/operadoras';

  Future<List<Operadora>> fetchOperadoras() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Operadora.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load operadoras');
    }
  }

  Future<Operadora?> fetchOperadoraBySigla(String sg_operadora) async {
    final response = await http.get(Uri.parse('$baseUrl/sg/$sg_operadora'));

    if (response.statusCode == 200) {
      return Operadora.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load operadora');
    }
  }
}
