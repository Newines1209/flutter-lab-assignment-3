import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/album_repository.dart';
import '../models/album.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository _albumRepository;

  AlbumCubit(this._albumRepository) : super(AlbumInitial());

  Future<void> fetchAlbums() async {
    emit(AlbumLoading());
    try {
      final albums = await _albumRepository.getAlbumsWithPhotos();
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError("Failed to fetch albums: ${e.toString()}"));
    }
  }
}