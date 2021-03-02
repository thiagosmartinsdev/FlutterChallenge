import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:trello_challenge/app/data/model/challenge_model.dart';

//nossa url base
const baseUrl = 'https://api.trello.com/1/';

//nossa classe responsável por encapsular os métodos http
class MyApiClient {
//seu client http, pode ser http, http.Client, dio, apenas traga seus métodos para cá e funcionarão normalmente :D
  final http.Client httpClient;
  MyApiClient({@required this.httpClient});

  final GetStorage box = GetStorage();

  static final key = '76f02f3def51ab7e5e5ae0940a9f3974';
  static final token =
      "497e40c2fd08b3067207dff7b664684693a40ba0eb3a361d0fd3fe6224a705fe";

  add(ChallengeModel model) async {
    String idBoard = await _createBoard(model.nome);
    box.write("idBoard", idBoard);
    String idList = await _createList(idBoard);
    box.write("idList", idList);
    _createCard(idList, model);
  }

  Future<String> _createCard(String idList, ChallengeModel model) async {
    var cardParams = {
      "key": key,
      "token": token,
      "name": model.nome,
      "desc": json.encode(model.toString()),
      "idList": idList
    };

    var queryString = Uri(queryParameters: cardParams).query;

    var url = baseUrl + "cards?" + queryString;

    try {
      var response = await httpClient.post(url);
      if (response.statusCode == 200) {
        Get.snackbar("Tudo certo", "Seu card foi criado com sucesso");
      }
    } on Exception {}
  }

  Future<String> _createList(String idBoard) async {
    var queryParams = {"key": key, "token": token, "name": "Flutter Challenge"};

    var queryString = Uri(queryParameters: queryParams).query;

    var url = baseUrl + "boards/" + idBoard + '/lists?' + queryString;

    try {
      var response = await httpClient.post(url);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body['id'];
      }
    } on Exception {}
  }

  Future<String> _createBoard(String boardName) async {
    var queryParams = {
      'key': key,
      'token': token,
      'name': "Flutter Challenge",
      'prefs_permissionLevel': 'public'
    };

    final uri =
        Uri.parse(baseUrl + "boards/?").replace(queryParameters: queryParams);

    try {
      var response = await httpClient.post(uri);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        Get.snackbar("Tudo certo", "O board foi inserido com sucesso");
        return body['id'];
      }
    } on Exception {}
  }
}
