import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/router.dart';
import 'data/api_service.dart';
import 'data/album_repository.dart';
import 'viewmodels/album_cubit.dart';

void main() {
  final apiService = ApiService();
  final albumRepository = AlbumRepository(apiService);
  runApp(MyApp(albumRepository: albumRepository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository albumRepository;

  const MyApp({super.key, required this.albumRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumCubit(albumRepository),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Album App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}