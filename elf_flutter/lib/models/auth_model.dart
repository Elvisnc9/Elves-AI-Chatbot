import 'dart:typed_data';

class AppUser {
  final String? name;
  final String? email;

  // If the profile exposes a URL, it goes here.
  final String? imageUrl;

  // If the profile exposes binary image data (ByteData / Uint8List) it goes here.
  final Uint8List? imageBytes;

  AppUser({
    this.name,
    this.email,
    this.imageUrl,
    this.imageBytes,
  });
}