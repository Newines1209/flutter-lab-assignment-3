import '../models/album.dart';
import '../models/photo.dart';
import 'api_service.dart';

class AlbumRepository {
  final ApiService _apiService;

  AlbumRepository(this._apiService);

  Future<List<Album>> getAlbumsWithPhotos() async {
    final albumJsonList = await _apiService.fetchAlbums();
    final photoJsonList = await _apiService.fetchPhotos();

    final photosByAlbumId = <int, Photo>{};
    for (var photoJson in photoJsonList) {
      final photo = Photo.fromJson(photoJson);
      if (!photosByAlbumId.containsKey(photo.albumId)) {
        photosByAlbumId[photo.albumId] = photo;
      }
    }

    return albumJsonList.map<Album>((json) {
      final album = Album.fromJson(json);
      album.thumbnailUrl = photosByAlbumId[album.id]?.thumbnailUrl ?? '';
      return album;
    }).toList();
  }
}