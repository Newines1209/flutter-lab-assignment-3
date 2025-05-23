import 'package:go_router/go_router.dart';
import '../views/album_list_screen.dart';
import '../views/album_detail_screen.dart';
import '../models/album.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          final album = state.extra as Album;
          return AlbumDetailScreen(album: album);
        },
      ),
    ],
  );
}