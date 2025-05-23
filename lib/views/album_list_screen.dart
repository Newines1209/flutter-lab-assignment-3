import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/album_cubit.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AlbumCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumInitial) {
            cubit.fetchAlbums();
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError){
            return Center(
              child: Card(
                color: Colors.amber[100],
                margin: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning, color: Colors.redAccent),
                      const SizedBox(height: 8),
                      const Text("Could not load albums. Please check your internet connection."),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => cubit.fetchAlbums(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AlbumLoaded) {
            final albums = state.albums;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  leading: Image.network(
                    album.thumbnailUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                  ),
                  title: Text(album.title),
                  onTap: () => context.push('/detail', extra: album),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}