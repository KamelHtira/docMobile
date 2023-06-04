import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String server = "https://angry-gold-tam.cyclic.app";
Future<Map<String, dynamic>> loginAPI(String email, String password) async {
  final response = await http.post(
    Uri.parse('$server/mobilelogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    // Save the id to shared preferences
    dynamic jsonBody = jsonDecode(response.body);
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', jsonBody["mobileUser"]["_id"]);
    print(jsonBody["mobileUser"]);
    await prefs.setString('firstName', jsonBody["mobileUser"]["firstName"]);
    await prefs.setString('lastName', jsonBody["mobileUser"]["lastName"]);
    await prefs.setString('birthday', jsonBody["mobileUser"]["birthday"]);
    await prefs.setString('sexe', jsonBody["mobileUser"]["sexe"]);
    await prefs.setString('phone', jsonBody["mobileUser"]["phone"]);
    return jsonBody;
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to fetch data');
  }
}

Future<Map<String, dynamic>> addAppointmentAPI(Object body) async {
  final response = await http.post(
    Uri.parse('$server/appointments'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    // If the server returns a 200 OK response, parse the JSON data
    // Save the id to shared preferences
    dynamic jsonBody = jsonDecode(response.body);
    return jsonBody;
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to fetch data');
  }
}

Future<Map<String, dynamic>> signupAPI(Object body) async {
  final response = await http.post(
    Uri.parse('$server/MobileUsers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    // Save the id to shared preferences
    dynamic jsonBody = jsonDecode(response.body);
    return jsonBody;
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to fetch data');
  }
}
