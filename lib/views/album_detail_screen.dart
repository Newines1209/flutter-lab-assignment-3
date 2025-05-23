import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final bool imageFailed = album.thumbnailUrl.isEmpty;

    return Scaffold(
      appBar: AppBar(title: Text('Album #${album.id}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            if (imageFailed)
              Container(
                width: double.infinity,
                color: Colors.amber[100],
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.warning, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Image could not be loaded.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                 
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        album.thumbnailUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            height: 200,
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            album.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text("Album ID: ${album.id}", style: const TextStyle(color: Colors.grey)),
                          Text("User ID: ${album.userId}", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
            if (imageFailed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Back and Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}