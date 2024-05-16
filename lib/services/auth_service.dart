

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAUtDd3HQCb7IDGv5pTIKsmUlhLjTQXFtk'; // Token de acceso a la api de firebase

  final storage = FlutterSecureStorage();

  // Si retornamos algo es un error si no todo bien
  Future<String?> createUser(String email, String password) async {
    //Para mandr inforacion a un POST, hay que mandarlo como mapa y despues serializarlo como mapa
    final Map<String,dynamic> authData = {
      'email'     :   email,
      'password'  :   password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key':_firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String,dynamic> decodedResp = json.decode(resp.body);
    // print(decodedResp);
    if(decodedResp.containsKey('idToken')){
      //Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // return decodedResp['idToken'];
      return null;
    }else{
      return decodedResp['error']['message'];
    }


  }

Future<String?> login(String email, String password) async {
    //Para mandr inforacion a un POST, hay que mandarlo como mapa y despues serializarlo como mapa
    final Map<String,dynamic> authData = {
      'email'     :   email,
      'password'  :   password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key':_firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String,dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if(decodedResp.containsKey('idToken')){
      //Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // return decodedResp['idToken'];
      return null;
    }else{
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }
  
}