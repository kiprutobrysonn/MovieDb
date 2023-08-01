import 'dart:convert';

import 'package:bloc_architect/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

class MovieProvider {
  Client client = Client();
  final _apiKey;

  Future<ItemModel> fetchMovieList() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load");
    }
  }
}
