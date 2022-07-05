import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

const storage = FlutterSecureStorage();

clearAllData()
{
  storage.deleteAll();
}
///JWT
Future<String> get jwtTokenGet async {
  var jwt = await storage.read(key: storageJWTKey);
  if (jwt == null) return "";
  return jwt;
}

set jwtTokenSet(String jwt) {
  storage.write(key: storageJWTKey, value: jwt);
}

///Name
Future<String> get getName async {
  var name = await storage.read(key: nameKey);
  if (name == null) return "";
  return name;
}

set setName(String name) {
  storage.write(key: nameKey, value: name);
}

///Registered Date
Future<String> get getDateRegistered async {
  var date = await storage.read(key: dateRegistered);
  if (date == null) return "";
  return date;
}

set setDateRegistered(String date) {
  storage.write(key: dateRegistered, value: date);
}

///Role
Future<String> get getUserRole async {
  var role = await storage.read(key: roleKey);
  if (role == null) return "";
  return role;
}

set setUserRole(String role) {
  storage.write(key: roleKey, value: role);
}

///Email ID
Future<String> get getEmailID async {
  var email = await storage.read(key: emailIdKey);
  if (email == null) return "";
  return email;
}

set setEmailID(String email) {
  storage.write(key: emailIdKey, value: email);
}

Future<String> get getUserId async {
  var userId = await storage.read(key: userIdKey);
  if (userId == null) return "";
  return userId;
}

set setUserId(String userId) {
  storage.write(key: userIdKey, value: userId);
}
