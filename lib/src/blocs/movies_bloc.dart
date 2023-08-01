import 'package:bloc_architect/src/models/item_model.dart';
import 'package:bloc_architect/src/resources/respository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _movieFetch = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies => _movieFetch.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _movieFetch.sink.add(itemModel);
  }

  dispose() {
    _movieFetch.close();
  }
}

final bloc = MoviesBloc();
