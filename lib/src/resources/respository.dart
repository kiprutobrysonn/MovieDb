import 'package:bloc_architect/src/models/item_model.dart';
import 'package:bloc_architect/src/resources/movie_api_provider.dart';

class Repository {
  final moviesApi = MovieProvider();
  Future<ItemModel> fetchAllMovies() => moviesApi.fetchMovieList();
}
